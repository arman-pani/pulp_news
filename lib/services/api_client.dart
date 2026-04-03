import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:odiya_news_app/services/token_storage.dart';

/// Singleton Dio client for all Railway REST API calls.
///
/// Handles:
/// - Base URL loaded from `.env`
/// - Bearer token injection on every request
/// - Automatic token refresh on 401, then retries the original request
/// - Pretty logging in debug mode
/// - Structured [ApiException] on every non-2xx response
class ApiClient {
  static ApiClient get instance => _instance;
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio _dio;

  ApiClient._internal() {
    final baseUrl = dotenv.env['RAILWAY_BASE_URL'] ?? '';
    assert(baseUrl.isNotEmpty,
        'RAILWAY_BASE_URL is not set in your .env file.');

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // 1. Auth interceptor — injects Bearer token & handles 401 refresh
    _dio.interceptors.add(_AuthInterceptor(_dio));

    // 2. Exception interceptor — converts HTTP / socket errors to ApiException
    _dio.interceptors.add(_ExceptionInterceptor());

    // 3. Pretty logger — only in debug builds
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }
  }

  Dio get dio => _dio;
}

// ---------------------------------------------------------------------------
// Auth interceptor
// ---------------------------------------------------------------------------

class _AuthInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;

  _AuthInterceptor(this._dio);

  TokenStorage get _tokens => Get.find<TokenStorage>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = _tokens.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 || _isRefreshing) {
      handler.next(err);
      return;
    }

    final refreshToken = _tokens.getRefreshToken();
    if (refreshToken == null) {
      handler.next(err);
      return;
    }

    _isRefreshing = true;
    try {
      // Use a separate Dio instance to avoid interceptor loops
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

      // Retry the original request with the new token
      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] =
          'Bearer ${data['access_token']}';

      final retryResponse = await _dio.fetch(retryOptions);
      handler.resolve(retryResponse);
    } catch (e) {
      debugPrint('[ApiClient] Token refresh failed: $e');
      // Clear stale tokens so the next cold start will create a new guest
      await _tokens.clearTokens();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
}

// ---------------------------------------------------------------------------
// Exception interceptor
// ---------------------------------------------------------------------------

class _ExceptionInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiError = ApiException.fromDioException(err);
    handler.next(
      err.copyWith(
        error: apiError,
        message: apiError.message,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ApiException
// ---------------------------------------------------------------------------

/// Structured error surface exposed to repositories / controllers.
class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic detail;

  const ApiException({
    this.statusCode,
    required this.message,
    this.detail,
  });

  factory ApiException.fromDioException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: 'Connection timed out. Check your internet connection.',
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'No internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final detail = err.response?.data is Map
            ? (err.response!.data as Map)['detail']
            : err.response?.data?.toString();
        return ApiException(
          statusCode: statusCode,
          message: detail?.toString() ??
              'Server error ($statusCode). Please try again.',
          detail: detail,
        );
      default:
        return ApiException(
          message: err.message ?? 'An unexpected error occurred.',
        );
    }
  }

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message)';
}
