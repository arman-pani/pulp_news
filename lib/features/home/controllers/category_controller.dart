import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

part 'category_controller.freezed.dart';
part 'category_controller.g.dart';

@freezed
class CategoryScreenState with _$CategoryScreenState {
  const factory CategoryScreenState({
    required String categoryName,
    @Default(<NewsModel>[]) List<NewsModel> articles,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMoreArticles,
    @Default(0) int currentOffset,
  }) = _CategoryScreenState;
}

@riverpod
class CategoryController extends _$CategoryController {
  static const int articlesPerPage = 20;
  late final ScrollController scrollController = ScrollController()
    ..addListener(_onScroll);
  bool _isLoadingMoreRequested = false;

  @override
  Future<CategoryScreenState> build(String categoryName) async {
    ref.onDispose(scrollController.dispose);
    return _loadCategoryArticles(categoryName);
  }

  Future<CategoryScreenState> _loadCategoryArticles(String categoryName) async {
    final articles = await ref
        .read(articlesRepositoryProvider)
        .getArticlesByCategory(categoryName, offset: 0, limit: articlesPerPage);

    return CategoryScreenState(
      categoryName: categoryName,
      articles: articles,
      hasMoreArticles: articles.length >= articlesPerPage,
      currentOffset: articles.length,
    );
  }

  void _onScroll() {
    if (_isLoadingMoreRequested ||
        !scrollController.hasClients ||
        scrollController.position.pixels <
            scrollController.position.maxScrollExtent * 0.8) {
      return;
    }

    _isLoadingMoreRequested = true;
    unawaited(loadMoreArticles().catchError((_) {}));
  }

  Future<void> refreshArticles() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadCategoryArticles(categoryName));
  }

  Future<void> loadMoreArticles() async {
    final currentState = state.valueOrNull;
    if (currentState == null ||
        !currentState.hasMoreArticles ||
        currentState.isLoadingMore ||
        currentState.isLoading) {
      _isLoadingMoreRequested = false;
      return;
    }

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final newArticles = await ref
          .read(articlesRepositoryProvider)
          .getArticlesByCategory(
            categoryName,
            offset: currentState.currentOffset,
            limit: articlesPerPage,
          );

      final nextState = currentState.copyWith(
        articles: [...currentState.articles, ...newArticles],
        currentOffset: currentState.currentOffset + newArticles.length,
        hasMoreArticles: newArticles.length >= articlesPerPage,
        isLoadingMore: false,
      );
      state = AsyncData(nextState);
    } catch (error, stackTrace) {
      state = AsyncData(currentState.copyWith(isLoadingMore: false));
      Error.throwWithStackTrace(error, stackTrace);
    } finally {
      _isLoadingMoreRequested = false;
    }
  }
}
