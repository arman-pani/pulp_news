import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:odiya_news_app/models/news_model.dart';

class HiveService {
  static const String _articlesBox = 'articles';
  static const String _bookmarksBox = 'bookmarks';
  static const String _recentSearchesBox = 'recent_searches';
  static const String _settingsBox = 'settings';
  static const String _fcmTokenKey = 'fcm_token';
  static const String _pendingNotificationArticlesKey =
      'pending_notification_articles';
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const int _maxArticlesLimit = 50; // Maximum articles to store

  late Box<NewsModel> _articlesBoxInstance;
  late Box<NewsModel> _bookmarksBoxInstance;
  late Box<String> _recentSearchesBoxInstance;
  late Box<String> _settingsBoxInstance;

  Future<HiveService> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NewsModelAdapter());

    _articlesBoxInstance = await Hive.openBox<NewsModel>(_articlesBox);
    _bookmarksBoxInstance = await Hive.openBox<NewsModel>(_bookmarksBox);
    _recentSearchesBoxInstance = await Hive.openBox<String>(_recentSearchesBox);
    _settingsBoxInstance = await Hive.openBox<String>(_settingsBox);

    return this;
  }

  // Articles methods with new logic
  Future<void> saveArticles(List<NewsModel> articles) async {
    for (final article in articles) {
      // Only save if article doesn't exist or if it's newer
      final existingArticle = _articlesBoxInstance.get(article.id);
      if (existingArticle == null) {
        await _articlesBoxInstance.put(article.id, article);
      }
    }

    // Maintain the limit of 50 articles by removing oldest ones
    await _maintainArticleLimit();
  }

  Future<void> _maintainArticleLimit() async {
    final allArticles = _articlesBoxInstance.values.toList();
    if (allArticles.length <= _maxArticlesLimit) {
      return; // No need to do anything if we're within the limit
    }

    // Sort by publishedAt in descending order (newest first)
    allArticles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    // Get the articles to remove (oldest ones beyond the limit)
    final articlesToRemove = allArticles.skip(_maxArticlesLimit).toList();

    // Remove only the excess articles by their IDs
    for (final article in articlesToRemove) {
      await _articlesBoxInstance.delete(article.id);
    }
  }

  List<NewsModel> getArticles() {
    return _articlesBoxInstance.values.toList();
  }

  List<NewsModel> getUnseenArticles() {
    final allArticles = _articlesBoxInstance.values.toList();
    // Filter unseen articles and sort by publishedAt in descending order
    return allArticles.where((article) => !article.isSeen).toList()
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  NewsModel? getArticle(String id) {
    return _articlesBoxInstance.get(id);
  }

  Future<void> markArticleAsSeen(String articleId) async {
    final article = _articlesBoxInstance.get(articleId);
    if (article != null) {
      final updatedArticle = article.copyWith(isSeen: true);
      await _articlesBoxInstance.put(articleId, updatedArticle);
    }
  }

  Future<void> clearArticles() async {
    await _articlesBoxInstance.clear();
  }

  bool hasUnseenArticles() {
    return _articlesBoxInstance.values.any((article) => !article.isSeen);
  }

  int getUnseenArticlesCount() {
    return _articlesBoxInstance.values
        .where((article) => !article.isSeen)
        .length;
  }

  // Bookmarks methods
  Future<void> addBookmark(NewsModel article) async {
    // Create a new instance to avoid Hive error
    final bookmarkArticle = NewsModel(
      id: article.id,
      title: article.title,
      content: article.content,
      imageUrl: article.imageUrl,
      author: article.author,
      sourceName: article.sourceName,
      sourceUrl: article.sourceUrl,
      publishedAt: article.publishedAt,
      category: article.category,
      createdAt: article.createdAt,
      isSeen: article.isSeen,
    );
    await _bookmarksBoxInstance.put(article.id, bookmarkArticle);
  }

  Future<void> removeBookmark(String articleId) async {
    await _bookmarksBoxInstance.delete(articleId);
  }

  bool isBookmarked(String articleId) {
    return _bookmarksBoxInstance.containsKey(articleId);
  }

  List<NewsModel> getBookmarkedArticles() {
    return _bookmarksBoxInstance.values.toList();
  }

  Future<void> clearAllBookmarks() async {
    await _bookmarksBoxInstance.clear();
  }

  // Recent searches methods
  Future<void> addRecentSearch(String query) async {
    if (query.trim().isEmpty) return;

    final searches = _recentSearchesBoxInstance.values.toList();
    searches.remove(query);
    searches.insert(0, query);

    // Keep only last 10
    final trimmed = searches.take(10).toList();
    await _recentSearchesBoxInstance.clear();
    await _recentSearchesBoxInstance.addAll(trimmed);
  }

  List<String> getRecentSearches() {
    return _recentSearchesBoxInstance.values.toList();
  }

  Future<void> clearRecentSearches() async {
    await _recentSearchesBoxInstance.clear();
  }

  // Settings methods
  Future<void> setThemeMode(bool isDark) async {
    await _settingsBoxInstance.put('isDarkMode', isDark.toString());
  }

  bool getThemeMode() {
    final value = _settingsBoxInstance.get('isDarkMode', defaultValue: 'false');
    return value == 'true';
  }

  Future<void> setLanguage(String language) async {
    await _settingsBoxInstance.put('language', language);
  }

  String getLanguage() {
    return _settingsBoxInstance.get('language', defaultValue: 'en') ?? 'en';
  }

  // FCM Token methods
  Future<void> storeFCMToken(String token) async {
    await _settingsBoxInstance.put(_fcmTokenKey, token);
  }

  String? getFCMToken() {
    return _settingsBoxInstance.get(_fcmTokenKey);
  }

  // Pending notification articles methods (handles multiple articles)
  Future<void> storePendingNotificationArticle(NewsModel article) async {
    // Get existing pending articles
    final existingJson =
        _settingsBoxInstance.get(
          _pendingNotificationArticlesKey,
          defaultValue: '[]',
        ) ??
        '[]';
    final List<dynamic> pendingArticles = json.decode(existingJson);

    // Add new article to the list
    pendingArticles.add(article.toMap());

    if (pendingArticles.length > 10) {
      pendingArticles.removeRange(0, pendingArticles.length - 10);
    }

    // Store updated list
    await _settingsBoxInstance.put(
      _pendingNotificationArticlesKey,
      json.encode(pendingArticles),
    );
  }

  Future<List<NewsModel>> getAndClearPendingNotificationArticles() async {
    final articlesJson =
        _settingsBoxInstance.get(
          _pendingNotificationArticlesKey,
          defaultValue: '[]',
        ) ??
        '[]';
    final List<dynamic> articlesList = json.decode(articlesJson);

    // Clear the pending articles
    await _settingsBoxInstance.delete(_pendingNotificationArticlesKey);

    // Convert to NewsModel list
    return articlesList
        .map((articleMap) => NewsModel.fromMap(articleMap))
        .toList();
  }

  // Notification settings methods
  Future<void> setNotificationEnabled(bool enabled) async {
    await _settingsBoxInstance.put(
      _notificationsEnabledKey,
      enabled.toString(),
    );
  }

  // In HiveService
  bool getNotificationEnabled() {
    if (!_settingsBoxInstance.containsKey(_notificationsEnabledKey)) {
      return true; // Default for existing users
    }
    final value = _settingsBoxInstance.get(_notificationsEnabledKey);
    return value == 'true';
  }

  // Add method to check if user is existing (no notification key set)
  bool isExistingUserWithoutNotificationSettings() {
    return !_settingsBoxInstance.containsKey(_notificationsEnabledKey);
  }

  // Close all boxes
  Future<void> close() async {
    await _articlesBoxInstance.close();
    await _bookmarksBoxInstance.close();
    await _recentSearchesBoxInstance.close();
    await _settingsBoxInstance.close();
  }
}
