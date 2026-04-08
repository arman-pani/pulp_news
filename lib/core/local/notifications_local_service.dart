import 'dart:convert';

import 'package:odiya_news_app/core/local/hive_service.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

class NotificationsLocalService {
  NotificationsLocalService(this._hiveService);

  static const fcmTokenKey = 'fcm_token';
  static const pendingNotificationArticlesKey = 'pending_notification_articles';
  static const notificationsEnabledKey = 'notifications_enabled';

  final HiveService _hiveService;

  Future<void> storeFCMToken(String token) async {
    await _hiveService.settingsBox.put(fcmTokenKey, token);
  }

  String? getFCMToken() {
    return _hiveService.settingsBox.get(fcmTokenKey);
  }

  Future<void> storePendingNotificationArticle(NewsModel article) async {
    final existingJson =
        _hiveService.settingsBox.get(
          pendingNotificationArticlesKey,
          defaultValue: '[]',
        ) ??
        '[]';
    final List<dynamic> pendingArticles = json.decode(existingJson);

    pendingArticles.add(article.toJson());

    if (pendingArticles.length > 10) {
      pendingArticles.removeRange(0, pendingArticles.length - 10);
    }

    await _hiveService.settingsBox.put(
      pendingNotificationArticlesKey,
      json.encode(pendingArticles),
    );
  }

  Future<List<NewsModel>> getAndClearPendingNotificationArticles() async {
    final articlesJson =
        _hiveService.settingsBox.get(
          pendingNotificationArticlesKey,
          defaultValue: '[]',
        ) ??
        '[]';
    final List<dynamic> articlesList = json.decode(articlesJson);

    await _hiveService.settingsBox.delete(pendingNotificationArticlesKey);

    return articlesList
        .map(
          (articleMap) =>
              NewsModel.fromJson(Map<String, dynamic>.from(articleMap as Map)),
        )
        .toList();
  }

  Future<void> setNotificationEnabled(bool enabled) async {
    await _hiveService.settingsBox.put(
      notificationsEnabledKey,
      enabled.toString(),
    );
  }

  bool getNotificationEnabled() {
    if (!_hiveService.settingsBox.containsKey(notificationsEnabledKey)) {
      return true;
    }

    final value = _hiveService.settingsBox.get(notificationsEnabledKey);
    return value == 'true';
  }

  bool isExistingUserWithoutNotificationSettings() {
    return !_hiveService.settingsBox.containsKey(notificationsEnabledKey);
  }
}
