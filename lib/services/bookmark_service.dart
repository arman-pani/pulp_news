import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/services/hive_service.dart';

class BookmarkService extends GetxService {
  static BookmarkService get instance => Get.find<BookmarkService>();
  late final HiveService hiveService;
  final RxList<NewsModel> _bookmarkedArticles = <NewsModel>[].obs;
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;

  // Getters
  List<NewsModel> get bookmarkedArticles => _bookmarkedArticles;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  bool get hasData => _bookmarkedArticles.isNotEmpty;
  bool get isEmpty => _bookmarkedArticles.isEmpty && !_isLoading && !_hasError;
  int get bookmarkCount => _bookmarkedArticles.length;

  @override
  void onInit() {
    super.onInit();
    hiveService = Get.find<HiveService>();
    loadBookmarkedArticles();
  }

  /// Load bookmarked articles from local database
  Future<void> loadBookmarkedArticles() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;

    try {
      _bookmarkedArticles.clear();
      _bookmarkedArticles.addAll(hiveService.getBookmarkedArticles());
    } catch (e) {
      _hasError = true;
      _errorMessage = _getErrorMessage(e);
      debugPrint('Error loading bookmarked articles: $e');
    }

    _isLoading = false;
  }

  /// Add a bookmark
  Future<void> addBookmark(NewsModel article) async {
    try {
      await hiveService.addBookmark(article);
      await loadBookmarkedArticles(); // Refresh the list
    } catch (e) {
      _hasError = true;
      _errorMessage = _getErrorMessage(e);
      debugPrint('Error adding bookmark: $e');
    }
  }

  /// Remove a bookmark
  Future<void> removeBookmark(String articleId) async {
    try {
      await hiveService.removeBookmark(articleId);
      await loadBookmarkedArticles(); // Refresh the list
    } catch (e) {
      _hasError = true;
      _errorMessage = _getErrorMessage(e);
      debugPrint('Error removing bookmark: $e');
    }
  }

  /// Toggle bookmark status for an article
  Future<void> toggleBookmark(NewsModel article) async {
    try {
      if (hiveService.isBookmarked(article.id)) {
        await removeBookmark(article.id);
      } else {
        await addBookmark(article);
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = _getErrorMessage(e);
      debugPrint('Error toggling bookmark: $e');
    }
  }

  /// Check if an article is bookmarked
  bool isBookmarked(String articleId) {
    return _bookmarkedArticles.any((article) => article.id == articleId);
  }

  /// Clear all bookmarked articles
  Future<void> clearAllBookmarks() async {
    try {
      await hiveService.clearAllBookmarks();
      await loadBookmarkedArticles();
    } catch (e) {
      _hasError = true;
      _errorMessage = _getErrorMessage(e);
      debugPrint('Error clearing all bookmarks: $e');
    }
  }

  /// Get error message based on error type
  String _getErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();
    
    // Database issues
    if (errorString.contains('hive') ||
        errorString.contains('database') ||
        errorString.contains('storage')) {
      return 'Unable to access local storage. Please try again.';
    }
    
    // Default message for other issues
    return 'Unable to load bookmarks. Please try again.';
  }
}
