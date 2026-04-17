import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/models/bundled_articles_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.freezed.dart';
part 'home_controller.g.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    @Default(<String>[]) List<String> categories,
    @Default(<NewsModel>[]) List<NewsModel> trendingNews,
    @Default(<String, List<NewsModel>>{})
    Map<String, List<NewsModel>> categoryArticles,
    BundledArticlesResponse? bundledArticles,
  }) = _HomeScreenState;
}

@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
  @override
  Future<HomeScreenState> build() async {
    return _loadBundledArticles();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadBundledArticles);
  }

  Future<HomeScreenState> _loadBundledArticles() async {
    final response = await ref
        .read(articlesRepositoryProvider)
        .getBundledArticles(limitPerCategory: 5);

    final categories = response.categories.keys.toList();
    final categoryArticles = <String, List<NewsModel>>{};
    
    // Use trending news directly from the response
    final trendingNews = response.trending;

    debugPrint("categories: $categories");
    debugPrint("trendingNews: $trendingNews");

    for (final categoryName in categories) {
      final articles = response.categories[categoryName]?.articles ?? const [];
      if (articles.isEmpty) continue;

      categoryArticles[categoryName] = articles;
    }

    debugPrint("categories: $categories");
    debugPrint("trendingNews: $trendingNews");

    return HomeScreenState(
      categories: categories,
      trendingNews: trendingNews,
      categoryArticles: categoryArticles,
      bundledArticles: response,
    );
  }
}
