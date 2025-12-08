import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/services/fcm_service.dart';

/// Handles deferred FCM initialization after navigation is complete
/// This prevents blocking the UI during onboarding completion
class FCMInitHandler {
  /// Initialize FCM in background after user completes onboarding
  /// This should be called AFTER navigation to home/explore screen
  static void initializeDeferredFCM() {
    // Run in next frame to ensure navigation is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runDeferredInit();
    });
  }

  static void _runDeferredInit() {
    try {
      // Check if FCMService is registered before attempting to use it
      if (!Get.isRegistered<FCMService>()) {
        debugPrint('FCMService not yet registered, deferring init...');
        // Try again after 1 second
        Future.delayed(const Duration(seconds: 1), _runDeferredInit);
        return;
      }

      // Request permission in background without blocking
      final fcmService = FCMService.to;
      fcmService.requestPermissionDeferred();
      
      debugPrint('FCM deferred initialization started');
    } catch (e) {
      debugPrint('Error in deferred FCM init: $e');
      // Retry once after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        try {
          if (Get.isRegistered<FCMService>()) {
            FCMService.to.requestPermissionDeferred();
          }
        } catch (retryError) {
          debugPrint('FCM retry failed: $retryError');
        }
      });
    }
  }
}
