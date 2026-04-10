import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:odiya_news_app/core/ads/ad_unit_ids.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_controller.freezed.dart';
part 'feed_controller.g.dart';

@freezed
class FeedScreenState with _$FeedScreenState {
  const factory FeedScreenState({
    @Default(<NewsModel>[]) List<NewsModel> articles,
    @Default(false) bool isLoading,
    @Default(false) bool noMoreArticles,
  }) = _FeedScreenState;
}

@Riverpod(keepAlive: true)
class FeedController extends _$FeedController {
  static const Duration _interstitialRetryDelay = Duration(seconds: 30);
  late final PageController pageController = PageController();
  InterstitialAd? _interstitialAd;
  bool _isInterstitialLoading = false;
  bool _isInterstitialShowing = false;
  int _lastShownInterstitialTrigger = 0;
  bool _isDisposed = false;
  static const int interstitialFrequency = 10;

  @override
  Future<FeedScreenState> build() async {
    ref.onDispose(() {
      _isDisposed = true;
      pageController.dispose();
      _interstitialAd?.dispose();
      _interstitialAd = null;
    });

    _loadInterstitialAd();
    unawaited(_checkAndMigrateExistingUser());

    final cachedArticles = ref
        .read(articlesLocalServiceProvider)
        .getUnseenArticles();
    var nextState = FeedScreenState(articles: cachedArticles);

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

  Future<FeedScreenState> _fetchMore(FeedScreenState currentState) async {
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
    final updatedArticles = [...currentState.articles, ...uniqueArticles];

    return currentState.copyWith(articles: updatedArticles, isLoading: false);
  }

  Future<void> loadMoreArticles() async {
    final currentState = state.valueOrNull ?? const FeedScreenState();
    if (currentState.isLoading) return;

    state = AsyncData(currentState.copyWith(isLoading: true));

    try {
      final nextState = await _fetchMore(state.requireValue);
      state = AsyncData(nextState);
    } catch (error, stackTrace) {
      state = AsyncData(currentState.copyWith(isLoading: false));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void refreshArticles() {
    state = const AsyncData(FeedScreenState());
    unawaited(loadMoreArticles().catchError((_) {}));
  }

  void onPageChanged(int index) {
    final currentState = state.valueOrNull;
    if (currentState == null ||
        index < 0 ||
        index >= currentState.articles.length) {
      return;
    }

    final article = currentState.articles[index];
    debugPrint(
      '[Ads][Interstitial] Article viewed.'
      ' index=$index'
      ' viewedCount=${index + 1}'
      ' ready=$_isInterstitialReady'
      ' loading=$_isInterstitialLoading'
      ' showing=$_isInterstitialShowing',
    );
    unawaited(_markAsSeen(article.id));
    _maybeShowInterstitial(index + 1);

    if (index >= currentState.articles.length - 3) {
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
    final currentState = state.valueOrNull ?? const FeedScreenState();
    final existingIndex = currentState.articles.indexWhere(
      (item) => item.id == article.id,
    );

    List<NewsModel> updatedArticles = currentState.articles;
    if (existingIndex == -1) {
      await ref.read(articlesLocalServiceProvider).saveArticles([article]);
      updatedArticles = [article, ...currentState.articles];
      state = AsyncData(currentState.copyWith(articles: updatedArticles));
    }

    await pageController.animateToPage(
      existingIndex == -1 ? 0 : existingIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _maybeShowInterstitial(int viewedArticleCount) {
    if (viewedArticleCount <= 1) {
      debugPrint('[Ads][Interstitial] Skip show on first article.');
      return;
    }

    if (viewedArticleCount % interstitialFrequency != 0) {
      debugPrint(
        '[Ads][Interstitial] Skip show. viewedCount=$viewedArticleCount'
        ' threshold=$interstitialFrequency',
      );
      return;
    }

    if (viewedArticleCount == _lastShownInterstitialTrigger) {
      debugPrint(
        '[Ads][Interstitial] Skip show. Trigger already used for count=$viewedArticleCount.',
      );
      return;
    }

    if (_isInterstitialShowing) {
      debugPrint(
        '[Ads][Interstitial] Skip show. Another interstitial is active.',
      );
      return;
    }

    final ad = _interstitialAd;
    if (ad == null) {
      debugPrint(
        '[Ads][Interstitial] Trigger reached at count=$viewedArticleCount'
        ' but no ad is ready.',
      );
      _loadInterstitialAd();
      return;
    }

    debugPrint(
      '[Ads][Interstitial] Showing interstitial at viewedCount=$viewedArticleCount.',
    );
    _isInterstitialShowing = true;
    _lastShownInterstitialTrigger = viewedArticleCount;
    _interstitialAd = null;
    ad.show();
  }

  void _loadInterstitialAd() {
    if (_isDisposed || _isInterstitialLoading || _interstitialAd != null) {
      if (!_isDisposed) {
        debugPrint(
          '[Ads][Interstitial] Load skipped.'
          ' loading=$_isInterstitialLoading'
          ' ready=${_interstitialAd != null}',
        );
      }
      return;
    }

    final adUnitId = AdUnitIds.interstitial;
    if (adUnitId.isEmpty) {
      debugPrint('[Ads][Interstitial] Ad unit ID is missing from .env');
      return;
    }

    debugPrint('[Ads][Interstitial] Starting preload.');
    _isInterstitialLoading = true;

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _isInterstitialLoading = false;
          debugPrint('[Ads][Interstitial] Preload succeeded.');
          _interstitialAd = ad
            ..fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                debugPrint('[Ads][Interstitial] Ad is now showing.');
              },
              onAdDismissedFullScreenContent: (ad) {
                debugPrint(
                  '[Ads][Interstitial] Ad dismissed. Reloading next ad.',
                );
                _isInterstitialShowing = false;
                ad.dispose();
                _loadInterstitialAd();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                debugPrint(
                  '[Ads][Interstitial] Failed to show.'
                  ' code=${error.code} message=${error.message}',
                );
                _isInterstitialShowing = false;
                ad.dispose();
                _loadInterstitialAd();
              },
            );
        },
        onAdFailedToLoad: (error) {
          _isInterstitialLoading = false;
          debugPrint(
            '[Ads][Interstitial] Preload failed.'
            ' code=${error.code} message=${error.message}',
          );
          if (_isDisposed) {
            return;
          }
          Future.delayed(_interstitialRetryDelay, () {
            if (!_isDisposed) {
              debugPrint('[Ads][Interstitial] Retrying preload.');
              _loadInterstitialAd();
            }
          });
        },
      ),
    );
  }

  bool get _isInterstitialReady => _interstitialAd != null;
}
