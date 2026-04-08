import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure wrapper around [FlutterSecureStorage] for JWT token persistence.
///
/// Tokens are stored in the OS keychain (iOS Keychain / Android Keystore).
/// An **in-memory cache** is kept after [init()] so that [ApiClient]
/// interceptors can read tokens synchronously.
class TokenStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const _kAccessToken = 'jwt_access_token';
  static const _kRefreshToken = 'jwt_refresh_token';
  static const _kUserId = 'jwt_user_id';

  // In-memory cache — populated on [init], kept in sync on every write
  String? _accessToken;
  String? _refreshToken;
  String? _userId;

  // ── Lifecycle ────────────────────────────────────────────────────────────

  /// Loads tokens from secure storage into the in-memory cache.
  /// Called once at app startup via [Get.putAsync].
  Future<TokenStorage> init() async {
    _accessToken = await _storage.read(key: _kAccessToken);
    _refreshToken = await _storage.read(key: _kRefreshToken);
    _userId = await _storage.read(key: _kUserId);
    debugPrint('[TokenStorage] Loaded — userId: $_userId');
    return this;
  }

  // ── Synchronous reads (from in-memory cache) ─────────────────────────────

  String? getAccessToken() => _accessToken;
  String? getRefreshToken() => _refreshToken;
  String? getUserId() => _userId;

  bool get hasSession => _accessToken != null && _accessToken!.isNotEmpty;

  // ── Writes (secure storage + cache) ──────────────────────────────────────

  Future<void> storeTokens({
    required String accessToken,
    required String refreshToken,
    required String userId,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _userId = userId;

    await Future.wait([
      _storage.write(key: _kAccessToken, value: accessToken),
      _storage.write(key: _kRefreshToken, value: refreshToken),
      _storage.write(key: _kUserId, value: userId),
    ]);

    debugPrint('[TokenStorage] Tokens stored for $userId');
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    _userId = null;

    await Future.wait([
      _storage.delete(key: _kAccessToken),
      _storage.delete(key: _kRefreshToken),
      _storage.delete(key: _kUserId),
    ]);

    debugPrint('[TokenStorage] Tokens cleared.');
  }
}
