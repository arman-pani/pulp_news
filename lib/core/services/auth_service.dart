import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/local/token_storage.dart';

/// Manages guest authentication with the Railway backend.
///
/// On [onInit] it will:
///   1. Check [TokenStorage] — if tokens exist, nothing more to do.
///   2. If no tokens exist, call `POST /auth/guest` to create a new guest
///      session and persist the returned token pair in secure storage.
///
/// The [ApiClient] interceptor handles all subsequent token refreshes
/// automatically, so callers never need to touch tokens directly.
class AuthService {
  AuthService({required Dio dio, required TokenStorage tokens})
    : _dio = dio,
      _tokens = tokens;

  final Dio _dio;
  final TokenStorage _tokens;

  String? get userId => _tokens.getUserId();
  bool get hasSession => _tokens.hasSession;

  Future<AuthService> init() async {
    await _bootstrap();
    return this;
  }

  /// Called once at startup. Creates a guest session if none exists.
  Future<void> _bootstrap() async {
    if (hasSession) {
      debugPrint('[AuthService] Existing session found for $userId');
      return;
    }
    await _createGuestSession();
  }

  /// Creates a new anonymous guest account and stores the token pair.
  Future<void> _createGuestSession() async {
    try {
      debugPrint('[AuthService] Creating new guest session…');
      final response = await _dio.post('/auth/guest');
      final data = response.data as Map<String, dynamic>;

      await _tokens.storeTokens(
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
        userId: data['user_id'] as String,
      );

      debugPrint('[AuthService] Guest session created: ${data['user_id']}');
    } catch (e) {
      debugPrint('[AuthService] Failed to create guest session: $e');
      rethrow;
    }
  }

  /// Returns the current access token (for cases where callers need it
  /// directly — normally the ApiClient interceptor handles this).
  String? getAccessToken() => _tokens.getAccessToken();

  /// Revokes the refresh token on the server and wipes local tokens.
  Future<void> logout() async {
    final refreshToken = _tokens.getRefreshToken();
    if (refreshToken != null) {
      try {
        await _dio.post('/auth/logout', data: {'refresh_token': refreshToken});
      } catch (e) {
        debugPrint('[AuthService] Logout request failed (ignoring): $e');
      }
    }
    await _tokens.clearTokens();
    debugPrint('[AuthService] Logged out — tokens cleared.');
  }

  /// Force-refreshes the access token immediately.
  Future<void> refreshSession() async {
    final refreshToken = _tokens.getRefreshToken();
    if (refreshToken == null) {
      await _createGuestSession();
      return;
    }

    try {
      final refreshDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl));
      final response = await refreshDio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      final data = response.data as Map<String, dynamic>;
      await _tokens.storeTokens(
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
        userId: data['user_id'] as String,
      );
      debugPrint('[AuthService] Session refreshed for ${data['user_id']}');
    } catch (e) {
      debugPrint('[AuthService] Refresh failed, creating new guest: $e');
      await _createGuestSession();
    }
  }
}
