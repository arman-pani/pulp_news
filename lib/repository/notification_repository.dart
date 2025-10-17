import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:odiya_news_app/services/auth_service.dart';
import 'package:odiya_news_app/services/firebase_functions_service.dart';

class NotificationRepository {
  static NotificationRepository get instance => _instance;
  static final NotificationRepository _instance = NotificationRepository._internal();
  factory NotificationRepository() => _instance;
  NotificationRepository._internal();

  final FirebaseFunctions _functions = FirebaseFunctionsService.instance.functions;

  /// Update user notification preferences on the server
  Future<bool> updateNotificationSettings({
    required bool enabled,
    required String fcmToken,
  }) async {
    try {

      final callable = _functions.httpsCallable('set_notification_preference_endpoint');
      final result = await callable.call({
        'isEnabled': enabled,
        'fcm_token': fcmToken,
      });

      final responseData = result.data;
      final success = responseData['success'] as bool? ?? false;
      
      if (success) {
        debugPrint('Notification settings updated successfully: $enabled');
      } else {
        debugPrint('Failed to update notification settings: ${responseData['error']}');
      }
      
      return success;
    } catch (e) {
      debugPrint('Error updating notification settings: $e');
      return false;
    }
  }

  /// Register FCM token with the server
  Future<bool> registerFCMToken(String fcmToken) async {
    try {
      // Get user ID token for authentication
      final idToken = await AuthService.to.getIdToken();
      if (idToken == null) {
        debugPrint('No user ID token available for FCM token registration');
        return false;
      }

      final callable = _functions.httpsCallable('update_fcm_token_endpoint');
      final result = await callable.call({
        'fcm_token': fcmToken,
        'id_token': idToken,
      });

      final responseData = result.data;
      final success = responseData['success'] as bool? ?? false;
      
      if (success) {
        debugPrint('FCM token registered successfully');
      } else {
        debugPrint('Failed to register FCM token: ${responseData['error']}');
      }
      
      return success;
    } catch (e) {
      debugPrint('Error registering FCM token: $e');
      return false;
    }
  }
}
