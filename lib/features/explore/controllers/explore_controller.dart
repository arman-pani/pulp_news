import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

part 'explore_controller.freezed.dart';
part 'explore_controller.g.dart';

@freezed
class ExploreScreenState with _$ExploreScreenState {
  const factory ExploreScreenState({
    @Default(<String>[]) List<String> categories,
    @Default(<NewsModel>[]) List<NewsModel> trendingNews,
    @Default(<String, List<NewsModel>>{})
    Map<String, List<NewsModel>> categoryArticles,
    @Default(<String, dynamic>{}) Map<String, dynamic> bundledArticles,
  }) = _ExploreScreenState;
}

@Riverpod(keepAlive: true)
class ExploreController extends _$ExploreController {
  @override
  Future<ExploreScreenState> build() async {
    return _loadBundledArticles();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadBundledArticles);
  }

  Future<ExploreScreenState> _loadBundledArticles() async {
    final response = await ref
        .read(articlesRepositoryProvider)
        .getBundledArticles(limitPerCategory: 5);

    final categoriesData =
        response['categories'] as Map<String, dynamic>? ?? {};
    final categories = categoriesData.keys.cast<String>().toList();
    final categoryArticles = <String, List<NewsModel>>{};
    final trendingNews = <NewsModel>[];

    for (final categoryName in categories) {
      final categoryData = categoriesData[categoryName] as Map<String, dynamic>;
      final rawArticles = (categoryData['articles'] as List? ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
      final articles = rawArticles.map(NewsModel.fromJson).toList();
      categoryArticles[categoryName] = articles;

      if (articles.length > 2) {
        trendingNews.add(articles[2]);
      }
    }

    return ExploreScreenState(
      categories: categories,
      trendingNews: trendingNews,
      categoryArticles: categoryArticles,
      bundledArticles: response,
    );
  }
}
