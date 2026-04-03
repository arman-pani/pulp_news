import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/repository/notification_repository.dart';
import 'package:odiya_news_app/services/hive_service.dart';
import 'package:odiya_news_app/home/home_controller.dart';
import 'package:odiya_news_app/utils/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:odiya_news_app/firebase_options.dart';

class FCMService extends GetxService {
  static FCMService get to => Get.find();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _notificationRepo = NotificationRepository.instance;
  final HiveService hiveService = Get.find<HiveService>();

  String? fcmToken;
  bool _initialized = false;
  bool _tokenRegistrationInProgress = false;
  bool _shouldRetryRegistration = false;

  Future<void> initializeIfNeeded() async {
    if (_initialized) return;
    _initialized = true;

    // Run setup tasks in parallel without blocking UI
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
        hiveService.storeFCMToken(fcmToken!);
        // Register token in background without blocking
        _registerTokenInBackground(fcmToken!);
      }
      debugPrint('FCM Token: $fcmToken');
    } catch (e) {
      debugPrint('FCM token error: $e');
      _shouldRetryRegistration = true;
    }
  }

  void _registerTokenInBackground(String token) {
    if (_tokenRegistrationInProgress) return;

    _tokenRegistrationInProgress = true;
    _notificationRepo
        .registerFCMToken(token)
        .then((_) {
          _tokenRegistrationInProgress = false;
          _shouldRetryRegistration = false;
          debugPrint('FCM token registered successfully');
        })
        .catchError((e) {
          _tokenRegistrationInProgress = false;
          _shouldRetryRegistration = true;
          debugPrint('FCM token registration failed: $e');
          // Retry after 5 seconds
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

  // Message Handlers
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
      _processNotification(data);
    }
  }

  // Notification Processing
  Future<void> _processNotification(Map<String, dynamic> data) async {
    if (data['type'] != 'new_article') return;

    try {
      final article = NewsModel.fromMap(data);

      if (Get.isRegistered<HomeController>()) {
        await _addToHomeController(article);
      } else {
        await hiveService.storePendingNotificationArticle(article);
      }

      goRouter.goNamed(AppRoutes.explore);
    } catch (e) {
      debugPrint('Error processing notification: $e');
    }
  }

  Future<void> _addToHomeController(NewsModel article) async {
    final homeCtrl = Get.find<HomeController>();

    final existingIndex = homeCtrl.articles.indexWhere(
      (a) => a.id == article.id,
    );

    if (existingIndex == -1) {
      homeCtrl.displayList.insert(0, article);
      await hiveService.saveArticles([article]);
      homeCtrl.buildDisplayList();
      homeCtrl.update();
    }

    homeCtrl.pageController.animateToPage(
      existingIndex == -1 ? 0 : existingIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<bool> toggleNotifications(bool enabled) async {
    try {
      // Update local storage first
      await hiveService.setNotificationEnabled(enabled);

      if (enabled) {
        // Request permission if enabling
        final settings = await _messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        if (settings.authorizationStatus != AuthorizationStatus.authorized) {
          // Permission denied, revert setting
          await hiveService.setNotificationEnabled(false);
          return false;
        }

        // Initialize FCM if not already done
        await initializeIfNeeded();

        // Register with server
        if (fcmToken != null) {
          debugPrint('##Registering FCM Token: $fcmToken');
          await _notificationRepo.registerFCMToken(fcmToken!);
          await _notificationRepo.updateNotificationSettings(
            enabled: true,
            fcmToken: fcmToken!,
          );
        }
      } else {
        // Disable notifications
        if (fcmToken != null) {
          await _notificationRepo.updateNotificationSettings(
            enabled: false,
            fcmToken: fcmToken!,
          );
        }
      }

      return true;
    } catch (e) {
      debugPrint('Error toggling notifications: $e');
      // Revert on error
      await hiveService.setNotificationEnabled(!enabled);
      return false;
    }
  }

  // Local Notifications
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
      iOS: DarwinNotificationDetails(
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

  /// Deferred permission request for post-navigation initialization
  /// This runs completely in background without blocking UI
  void requestPermissionDeferred() {
    requestPermission()
        .then((authorized) {
          if (authorized) {
            debugPrint('FCM permission granted (deferred)');
          } else {
            debugPrint('FCM permission denied (deferred)');
          }
        })
        .catchError((e) {
          debugPrint('FCM permission error (deferred): $e');
        });
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

    final settingsBox = await Hive.openBox<String>('settings');
    final data = message.data;

    if (data['type'] == 'new_article') {
      final article = NewsModel.fromMap(data);

      final existingJson =
          settingsBox.get(
            'pending_notification_articles',
            defaultValue: '[]',
          ) ??
          '[]';

      final List<dynamic> pendingArticles = json.decode(existingJson);
      pendingArticles.add(article.toMap());

      if (pendingArticles.length > 10) {
        pendingArticles.removeRange(0, pendingArticles.length - 10);
      }

      await settingsBox.put(
        'pending_notification_articles',
        json.encode(pendingArticles),
      );
    }
  } catch (e, st) {
    debugPrint('Background error: $e');
    debugPrintStack(stackTrace: st);
  }
}
