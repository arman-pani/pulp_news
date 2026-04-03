import 'package:flutter/material.dart';
import 'package:odiya_news_app/services/auth_service.dart';

/// Thin utility wrapper kept for backwards compatibility.
/// Auth is now handled entirely by [AuthService] via JWT guest tokens.
class AuthHandler {
  static Future<void> ensureSession() async {
    if (!AuthService.to.hasSession) {
      await AuthService.to.refreshSession();
    }
    debugPrint('[AuthHandler] Session user: ${AuthService.to.userId}');
  }
}
