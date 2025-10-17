import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/repository/articles_repository.dart';
import 'package:odiya_news_app/services/fcm_service.dart';
import 'package:odiya_news_app/services/hive_service.dart';

class HomeController extends GetxController {
  final hiveService = Get.find<HiveService>();
  final ArticlesRepository _repo = ArticlesRepository();

  List<NewsModel> articles = [];
  List<dynamic> displayList = []; // Articles + ads
  NativeAd? nativeAd;
  bool _isAdLoading = false;

  bool isLoading = false;
  bool hasError = false;
  bool noMoreArticles = false;

  final PageController pageController = PageController();
  final int adFrequency = 5; // Show ad after every 5 articles

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
    _loadNativeAd(); // Added native ad loading

    _checkAndMigrateExistingUser();
  }

  @override
  void onClose() {
    pageController.dispose();
    nativeAd?.dispose();
    super.onClose();
  }

  Future<void> _checkAndMigrateExistingUser() async {
    // Check if user is existing (no notification settings
    debugPrint('Checking and migrating existing user');
    if (hiveService.isExistingUserWithoutNotificationSettings()) {
      debugPrint('Migrating existing user');
      // Auto-request permission using system dialog
      await FCMService.to.requestPermission();
    } else {
      debugPrint('user has notification settings');
    }
  }

  Future<void> _loadInitialData() async {
    // Load cached articles first
    await _loadCachedArticles();

    // Fetch more if we don't have enough
    if (articles.isEmpty || articles.length < 3) {
      await loadMoreArticles();
    }
  }

  Future<void> _loadCachedArticles() async {
    articles = hiveService.getUnseenArticles();
    buildDisplayList();
    update();
  }

  Future<void> loadMoreArticles() async {
    if (isLoading) return;

    isLoading = true;
    update();

    try {
      final newArticles = await _repo.getUnseenArticles(limit: 20);

      if (newArticles.isEmpty) {
        noMoreArticles = true;
      } else {
        // Remove duplicates and add new articles
        final existingIds = articles.map((a) => a.id).toSet();
        final uniqueArticles = newArticles
            .where((a) => !existingIds.contains(a.id))
            .toList();

        articles.addAll(uniqueArticles);
        await hiveService.saveArticles(uniqueArticles);
        buildDisplayList();
      }
    } catch (e) {
      hasError = true;
      debugPrint('Error: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void buildDisplayList() {
    displayList.clear();

    // Add articles and ads at intervals
    for (int i = 0; i < articles.length; i++) {
      displayList.add(articles[i]);

      // Add ad after every few articles
      if (nativeAd != null && i > 0 && (i + 1) % adFrequency == 0) {
        displayList.add(nativeAd!);
      }
    }
  }

  // Native Ad Methods
  void _loadNativeAd() {
    if (_isAdLoading) return;

    // Dispose old ad before creating new one
    nativeAd?.dispose();

    _isAdLoading = true;
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // Test ID
      factoryId: 'nativeAd',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          _isAdLoading = false;
          debugPrint('Native ad loaded');
          buildDisplayList(); // Rebuild list to include the ad
          update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          _isAdLoading = false;
          debugPrint('Native ad failed to load: $error');
          // Retry after delay
          Future.delayed(const Duration(minutes: 1), _loadNativeAd);
        },
      ),
    )..load();
  }

  void onPageChanged(int index) {
    if (_isAd(index)) return;

    // Mark article as seen
    final articleIndex = _getArticleIndex(index);
    if (articleIndex != -1) {
      _markAsSeen(articles[articleIndex].id);
    }

    // Load more when near end
    if (articleIndex >= articles.length - 3) {
      loadMoreArticles();
    }
  }

  Future<void> _markAsSeen(String articleId) async {
    await hiveService.markArticleAsSeen(articleId);

    final index = articles.indexWhere((a) => a.id == articleId);
    if (index != -1) {
      articles[index] = articles[index].copyWith(isSeen: true);
      update();
    }
  }

  void refreshArticles() {
    articles.clear();
    displayList.clear();
    hasError = false;
    noMoreArticles = false;
    loadMoreArticles();
  }

  // Helper methods
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

  NewsModel? getArticleAt(int index) {
    if (index < displayList.length && displayList[index] is NewsModel) {
      return displayList[index] as NewsModel;
    }
    return null;
  }

  // Getters
  bool get hasData => articles.isNotEmpty;
  bool get shouldShowLoading => articles.isEmpty && isLoading;
  bool get shouldShowError => articles.isEmpty && hasError;
  int get unseenCount => hiveService.getUnseenArticlesCount();
  bool get isNativeAdLoaded => nativeAd != null; // Added getter for ad status
}
