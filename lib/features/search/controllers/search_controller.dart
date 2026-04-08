import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';

part 'search_controller.freezed.dart';
part 'search_controller.g.dart';

@freezed
class SearchScreenState with _$SearchScreenState {
  const factory SearchScreenState({
    @Default(<NewsModel>[]) List<NewsModel> searchResults,
    @Default(<String>[]) List<String> recentSearches,
    @Default(false) bool isSearching,
    @Default('') String currentQuery,
  }) = _SearchScreenState;
}

@Riverpod(keepAlive: true)
class SearchController extends _$SearchController {
  @override
  SearchScreenState build() {
    return SearchScreenState(
      recentSearches: ref
          .read(recentSearchesLocalServiceProvider)
          .getRecentSearches(),
    );
  }

  Future<void> searchArticles(String query) async {
    if (query.trim().isEmpty) {
      clearSearch();
      return;
    }

    state = state.copyWith(currentQuery: query, isSearching: true);

    try {
      final results = await ref
          .read(articlesRepositoryProvider)
          .searchArticles(query);
      await ref.read(recentSearchesLocalServiceProvider).addRecentSearch(query);

      state = state.copyWith(
        searchResults: results,
        recentSearches: ref
            .read(recentSearchesLocalServiceProvider)
            .getRecentSearches(),
      );
    } finally {
      state = state.copyWith(isSearching: false);
    }
  }

  void clearSearch() {
    state = state.copyWith(
      searchResults: const [],
      currentQuery: '',
      isSearching: false,
    );
  }

  Future<void> clearRecentSearches() async {
    await ref.read(recentSearchesLocalServiceProvider).clearRecentSearches();
    state = state.copyWith(recentSearches: const []);
  }

  bool get shouldShowRecentSearches =>
      state.currentQuery.isEmpty && !state.isSearching;
}
