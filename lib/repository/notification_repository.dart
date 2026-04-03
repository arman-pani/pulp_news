import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odiya_news_app/services/api_client.dart';

class NotificationRepository {
  static NotificationRepository get instance => _instance;
  static final NotificationRepository _instance =
      NotificationRepository._internal();
  factory NotificationRepository() => _instance;
  NotificationRepository._internal();

  final Dio _dio = ApiClient.instance.dio;

  /// Register or update the FCM device token for the authenticated user.
  /// The Bearer token is injected automatically by [ApiClient].
  Future<bool> registerFCMToken(String fcmToken) async {
    try {
      final response = await _dio.post(
        '/users/me/fcm-token',
        data: {'fcm_token': fcmToken},
      );

      final success =
          (response.data as Map<String, dynamic>)['success'] as bool? ?? false;

      if (success) {
        debugPrint('[NotificationRepository] FCM token registered.');
      } else {
        debugPrint('[NotificationRepository] FCM token registration failed.');
      }

      return success;
    } catch (e) {
      debugPrint('[NotificationRepository] registerFCMToken error: $e');
      return false;
    }
  }

  /// Enable or disable push notifications.
  /// Optionally updates the FCM token at the same time.
  Future<bool> updateNotificationSettings({
    required bool enabled,
    String? fcmToken,
  }) async {
    try {
      final body = <String, dynamic>{'is_enabled': enabled};
      if (fcmToken != null) body['fcm_token'] = fcmToken;

      final response = await _dio.post(
        '/users/me/notification-preference',
        data: body,
      );

      final success =
          (response.data as Map<String, dynamic>)['success'] as bool? ?? false;

      debugPrint(
        '[NotificationRepository] Notification preference '
        '${enabled ? "enabled" : "disabled"}: $success',
      );

      return success;
    } catch (e) {
      debugPrint('[NotificationRepository] updateNotificationSettings error: $e');
      return false;
    }
  }
}
