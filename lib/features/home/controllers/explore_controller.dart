import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/models/bundled_articles_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'explore_controller.freezed.dart';
part 'explore_controller.g.dart';

@freezed
class ExploreScreenState with _$ExploreScreenState {
  const factory ExploreScreenState({
    @Default(<String>[]) List<String> categories,
    @Default(<NewsModel>[]) List<NewsModel> trendingNews,
    @Default(<String, List<NewsModel>>{})
    Map<String, List<NewsModel>> categoryArticles,
    BundledArticlesResponse? bundledArticles,
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

    final categories = response.categories.keys.toList();
    final categoryArticles = <String, List<NewsModel>>{};
    final trendingNews = <NewsModel>[];

    debugPrint("categories: $categories");
    debugPrint("trendingNews: $trendingNews");

    for (final categoryName in categories) {
      final articles = response.categories[categoryName]?.articles ?? const [];
      if (articles.isEmpty) continue;

      categoryArticles[categoryName] = articles;

      if (articles.length > 2) {
        trendingNews.add(articles[2]);
      }
    }

    debugPrint("categories: $categories");
    debugPrint("trendingNews: $trendingNews");

    return ExploreScreenState(
      categories: categories,
      trendingNews: trendingNews,
      categoryArticles: categoryArticles,
      bundledArticles: response,
    );
  }
}
