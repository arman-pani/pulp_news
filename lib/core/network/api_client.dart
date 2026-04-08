import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/local/token_storage.dart';
import 'package:odiya_news_app/core/services/app_snackbar_service.dart';

/// Singleton Dio client for all Railway REST API calls.
///
/// Handles:
/// - Base URL loaded from `.env`
/// - Bearer token injection on every request
/// - Automatic token refresh on 401, then retries the original request
/// - Pretty logging in debug mode
/// - Structured [ApiException] on every non-2xx response
class ApiClient {
  final TokenStorage _tokens;
  final AppSnackbarService _snackbarService;
  late final Dio _dio;

  ApiClient({
    required TokenStorage tokens,
    required AppSnackbarService snackbarService,
  }) : _tokens = tokens,
       _snackbarService = snackbarService {
    final baseUrl = dotenv.env['RAILWAY_BASE_URL'] ?? '';
    assert(
      baseUrl.isNotEmpty,
      'RAILWAY_BASE_URL is not set in your .env file.',
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // 1. Auth interceptor — injects Bearer token & handles 401 refresh
    _dio.interceptors.add(_AuthInterceptor(_dio, _tokens));

    // 2. Exception interceptor — converts HTTP / socket errors to ApiException
    _dio.interceptors.add(_ExceptionInterceptor(_snackbarService));

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
  final TokenStorage _tokens;
  bool _isRefreshing = false;

  _AuthInterceptor(this._dio, this._tokens);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
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
      retryOptions.headers['Authorization'] = 'Bearer ${data['access_token']}';

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
  _ExceptionInterceptor(this._snackbarService);

  final AppSnackbarService _snackbarService;
  static const _snackbarDedupWindow = Duration(seconds: 2);
  static DateTime? _lastSnackbarAt;
  static String? _lastSnackbarMessage;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiError = err.error is ApiException
        ? err.error as ApiException
        : ApiException.fromDioException(err);
    _showErrorSnackbar(err.requestOptions, apiError.message);
    handler.next(err.copyWith(error: apiError, message: apiError.message));
  }

  void _showErrorSnackbar(RequestOptions requestOptions, String message) {
    if (requestOptions.extra['error_snackbar_shown'] == true) {
      return;
    }
    requestOptions.extra['error_snackbar_shown'] = true;

    final now = DateTime.now();
    final shownRecently =
        _lastSnackbarMessage == message &&
        _lastSnackbarAt != null &&
        now.difference(_lastSnackbarAt!) < _snackbarDedupWindow;

    if (shownRecently) {
      return;
    }

    _lastSnackbarMessage = message;
    _lastSnackbarAt = now;

    _snackbarService.hideCurrent();
    _snackbarService.showError('$AppStrings.error: $message');
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

  const ApiException({this.statusCode, required this.message, this.detail});

  factory ApiException.fromDioException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: 'Connection timed out. Check your internet connection.',
        );
      case DioExceptionType.connectionError:
        return const ApiException(message: 'No internet connection.');
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final detail = err.response?.data is Map
            ? (err.response!.data as Map)['detail']
            : err.response?.data?.toString();
        return ApiException(
          statusCode: statusCode,
          message:
              detail?.toString() ??
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
