import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:odiya_news_app/core/local/hive_service.dart';
import 'package:odiya_news_app/core/local/notifications_local_service.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/features/feed/controllers/feed_controller.dart';
import 'package:odiya_news_app/firebase_options.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

class FCMService {
  FCMService(this.ref);

  final Ref ref;
  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  String? fcmToken;
  bool _initialized = false;
  bool _tokenRegistrationInProgress = false;
  bool _shouldRetryRegistration = false;

  Future<void> initializeIfNeeded() async {
    if (_initialized) return;
    _initialized = true;

    unawaited(_setupLocalNotifications());
    unawaited(_getToken());
    unawaited(_setupMessageHandlers());
  }

  Future<void> _setupLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  Future<void> _getToken() async {
    try {
      fcmToken = await _messaging.getToken();
      if (fcmToken != null) {
        await ref
            .read(notificationsLocalServiceProvider)
            .storeFCMToken(fcmToken!);
        _registerTokenInBackground(fcmToken!);
      }
    } catch (e) {
      debugPrint('FCM token error: $e');
      _shouldRetryRegistration = true;
    }
  }

  void _registerTokenInBackground(String token) {
    if (_tokenRegistrationInProgress) return;

    _tokenRegistrationInProgress = true;
    ref
        .read(notificationRepositoryProvider)
        .registerFCMToken(token)
        .then((_) {
          _tokenRegistrationInProgress = false;
          _shouldRetryRegistration = false;
        })
        .catchError((e) {
          _tokenRegistrationInProgress = false;
          _shouldRetryRegistration = true;
          Future.delayed(const Duration(seconds: 5), () {
            if (_shouldRetryRegistration && fcmToken != null) {
              _registerTokenInBackground(fcmToken!);
            }
          });
        });
  }

  Future<void> _setupMessageHandlers() async {
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_foregroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_notificationTap);
    _handleInitialMessage();
  }

  Future<void> _foregroundMessage(RemoteMessage message) async {
    await _showLocalNotification(message);
  }

  Future<void> _notificationTap(RemoteMessage message) async {
    await _processNotification(message.data);
  }

  Future<void> _handleInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    if (message != null) await _processNotification(message.data);
  }

  void _onNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      final data = json.decode(response.payload!);
      _processNotification(Map<String, dynamic>.from(data as Map));
    }
  }

  Future<void> _processNotification(Map<String, dynamic> data) async {
    if (data['type'] != 'new_article') return;

    try {
      final article = NewsModel.fromJson(data);
      await ref
          .read(feedControllerProvider.notifier)
          .addNotificationArticle(article);
      ref.read(appRouterProvider).router.go(AppRoutes.home);
    } catch (e) {
      debugPrint('Error processing notification: $e');
      await ref
          .read(notificationsLocalServiceProvider)
          .storePendingNotificationArticle(NewsModel.fromJson(data));
    }
  }

  Future<bool> toggleNotifications(bool enabled) async {
    try {
      await ref
          .read(notificationsLocalServiceProvider)
          .setNotificationEnabled(enabled);

      if (enabled) {
        final settings = await _messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        if (settings.authorizationStatus != AuthorizationStatus.authorized) {
          await ref
              .read(notificationsLocalServiceProvider)
              .setNotificationEnabled(false);
          return false;
        }

        await initializeIfNeeded();

        if (fcmToken != null) {
          await ref
              .read(notificationRepositoryProvider)
              .registerFCMToken(fcmToken!);
          await ref
              .read(notificationRepositoryProvider)
              .updateNotificationSettings(enabled: true, fcmToken: fcmToken!);
        }
      } else if (fcmToken != null) {
        await ref
            .read(notificationRepositoryProvider)
            .updateNotificationSettings(enabled: false, fcmToken: fcmToken!);
      }

      return true;
    } catch (e) {
      debugPrint('Error toggling notifications: $e');
      await ref
          .read(notificationsLocalServiceProvider)
          .setNotificationEnabled(!enabled);
      return false;
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'news_channel',
        'News Notifications',
        channelDescription: 'Notifications for new news articles',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotifications.show(
      message.hashCode,
      notification.title,
      notification.body,
      details,
      payload: json.encode(message.data),
    );
  }

  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final authorized =
        settings.authorizationStatus == AuthorizationStatus.authorized;
    if (authorized) unawaited(initializeIfNeeded());
    return authorized;
  }

  void requestPermissionDeferred() {
    unawaited(
      requestPermission().catchError((e) {
        debugPrint('FCM permission error (deferred): $e');
        return false;
      }),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NewsModelAdapter());
    }

    final settingsBox = await Hive.openBox<String>(HiveService.settingsBoxName);
    final data = message.data;

    if (data['type'] == 'new_article') {
      final article = NewsModel.fromJson(data);

      final existingJson =
          settingsBox.get(
            NotificationsLocalService.pendingNotificationArticlesKey,
            defaultValue: '[]',
          ) ??
          '[]';

      final List<dynamic> pendingArticles = json.decode(existingJson);
      pendingArticles.add(article.toJson());

      if (pendingArticles.length > 10) {
        pendingArticles.removeRange(0, pendingArticles.length - 10);
      }

      await settingsBox.put(
        NotificationsLocalService.pendingNotificationArticlesKey,
        json.encode(pendingArticles),
      );
    }
  } catch (e, st) {
    debugPrint('Background error: $e');
    debugPrintStack(stackTrace: st);
  }
}
