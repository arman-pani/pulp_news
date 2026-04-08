import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

part 'home_controller.freezed.dart';
part 'home_controller.g.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    @Default(<NewsModel>[]) List<NewsModel> articles,
    @Default(false) bool isLoading,
    @Default(false) bool noMoreArticles,
    @Default(false) bool isNativeAdLoaded,
  }) = _HomeScreenState;
}

@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
  late final PageController pageController = PageController();
  NativeAd? nativeAd;
  bool _isAdLoading = false;
  static const int adFrequency = 5;

  @override
  Future<HomeScreenState> build() async {
    ref.onDispose(() {
      pageController.dispose();
      nativeAd?.dispose();
    });

    _loadNativeAd();
    unawaited(_checkAndMigrateExistingUser());

    final cachedArticles = ref
        .read(articlesLocalServiceProvider)
        .getUnseenArticles();
    var nextState = HomeScreenState(articles: cachedArticles);

    if (cachedArticles.length < 3) {
      nextState = await _fetchMore(nextState);
    }

    return nextState;
  }

  Future<void> _checkAndMigrateExistingUser() async {
    final notificationsLocalService = ref.read(
      notificationsLocalServiceProvider,
    );
    if (notificationsLocalService.isExistingUserWithoutNotificationSettings()) {
      await ref.read(fcmServiceProvider).requestPermission();
    }
  }

  List<dynamic> get displayList {
    final data = state.valueOrNull;
    if (data == null) return const [];

    final list = <dynamic>[];
    for (int i = 0; i < data.articles.length; i++) {
      list.add(data.articles[i]);
      if (nativeAd != null && i > 0 && (i + 1) % adFrequency == 0) {
        list.add(nativeAd!);
      }
    }
    return list;
  }

  Future<HomeScreenState> _fetchMore(HomeScreenState currentState) async {
    final newArticles = await ref
        .read(articlesRepositoryProvider)
        .getUnseenArticles(limit: 20);

    if (newArticles.isEmpty) {
      return currentState.copyWith(noMoreArticles: true, isLoading: false);
    }

    final existingIds = currentState.articles
        .map((article) => article.id)
        .toSet();
    final uniqueArticles = newArticles
        .where((article) => !existingIds.contains(article.id))
        .toList();

    await ref.read(articlesLocalServiceProvider).saveArticles(uniqueArticles);

    return currentState.copyWith(
      articles: [...currentState.articles, ...uniqueArticles],
      isLoading: false,
    );
  }

  Future<void> loadMoreArticles() async {
    final currentState = state.valueOrNull ?? const HomeScreenState();
    if (currentState.isLoading) return;

    state = AsyncData(currentState.copyWith(isLoading: true));

    try {
      final nextState = await _fetchMore(state.requireValue);
      state = AsyncData(nextState.copyWith(isNativeAdLoaded: nativeAd != null));
    } catch (error, stackTrace) {
      state = AsyncData(currentState.copyWith(isLoading: false));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void refreshArticles() {
    state = const AsyncData(HomeScreenState());
    unawaited(loadMoreArticles().catchError((_) {}));
  }

  void onPageChanged(int index) {
    if (_isAd(index)) return;

    final articleIndex = _getArticleIndex(index);
    final currentState = state.valueOrNull;
    if (currentState == null || articleIndex == -1) return;

    unawaited(_markAsSeen(currentState.articles[articleIndex].id));

    if (articleIndex >= currentState.articles.length - 3) {
      unawaited(loadMoreArticles().catchError((_) {}));
    }
  }

  Future<void> _markAsSeen(String articleId) async {
    await ref.read(articlesLocalServiceProvider).markArticleAsSeen(articleId);

    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final index = currentState.articles.indexWhere(
      (article) => article.id == articleId,
    );
    if (index == -1) return;

    final updatedArticles = [...currentState.articles];
    updatedArticles[index] = updatedArticles[index].copyWith(isSeen: true);
    state = AsyncData(currentState.copyWith(articles: updatedArticles));
  }

  Future<void> addNotificationArticle(NewsModel article) async {
    final currentState = state.valueOrNull ?? const HomeScreenState();
    final existingIndex = currentState.articles.indexWhere(
      (item) => item.id == article.id,
    );

    if (existingIndex == -1) {
      await ref.read(articlesLocalServiceProvider).saveArticles([article]);
      state = AsyncData(
        currentState.copyWith(articles: [article, ...currentState.articles]),
      );
    }

    await pageController.animateToPage(
      existingIndex == -1 ? 0 : existingIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _loadNativeAd() {
    if (_isAdLoading) return;

    nativeAd?.dispose();
    _isAdLoading = true;
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      factoryId: 'nativeAd',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          _isAdLoading = false;
          final currentState = state.valueOrNull;
          if (currentState != null) {
            state = AsyncData(currentState.copyWith(isNativeAdLoaded: true));
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          _isAdLoading = false;
          Future.delayed(const Duration(minutes: 1), _loadNativeAd);
        },
      ),
    )..load();
  }

  bool _isAd(int index) =>
      index < displayList.length && displayList[index] is NativeAd;

  int _getArticleIndex(int displayIndex) {
    int articleCount = 0;
    for (int i = 0; i <= displayIndex; i++) {
      if (i < displayList.length && displayList[i] is NewsModel) {
        articleCount++;
      }
    }
    return articleCount - 1;
  }
}
