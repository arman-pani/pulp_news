import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odiya_news_app/core/local/articles_local_service.dart';
import 'package:odiya_news_app/core/local/bookmarks_local_service.dart';
import 'package:odiya_news_app/core/local/hive_service.dart';
import 'package:odiya_news_app/core/local/notifications_local_service.dart';
import 'package:odiya_news_app/core/local/recent_searches_local_service.dart';
import 'package:odiya_news_app/core/local/settings_local_service.dart';
import 'package:odiya_news_app/core/local/token_storage.dart';
import 'package:odiya_news_app/core/network/api_client.dart';
import 'package:odiya_news_app/core/routing/app_router.dart';
import 'package:odiya_news_app/core/services/app_snackbar_service.dart';
import 'package:odiya_news_app/core/repository/articles_repository.dart';
import 'package:odiya_news_app/core/repository/languages_repository.dart';
import 'package:odiya_news_app/core/repository/notification_repository.dart';
import 'package:odiya_news_app/core/services/auth_service.dart';
import 'package:odiya_news_app/core/services/fcm_service.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
AppSnackbarService appSnackbarService(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
HiveService hiveBootstrap(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
ArticlesLocalService articlesLocalService(Ref ref) {
  return ArticlesLocalService(ref.watch(hiveBootstrapProvider));
}

@Riverpod(keepAlive: true)
BookmarksLocalService bookmarksLocalService(Ref ref) {
  return BookmarksLocalService(ref.watch(hiveBootstrapProvider));
}

@Riverpod(keepAlive: true)
RecentSearchesLocalService recentSearchesLocalService(Ref ref) {
  return RecentSearchesLocalService(ref.watch(hiveBootstrapProvider));
}

@Riverpod(keepAlive: true)
SettingsLocalService settingsLocalService(Ref ref) {
  return SettingsLocalService(ref.watch(hiveBootstrapProvider));
}

@Riverpod(keepAlive: true)
NotificationsLocalService notificationsLocalService(Ref ref) {
  return NotificationsLocalService(ref.watch(hiveBootstrapProvider));
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient(
    tokens: ref.watch(tokenStorageProvider),
    snackbarService: ref.watch(appSnackbarServiceProvider),
  );
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return ref.watch(apiClientProvider).dio;
}

@Riverpod(keepAlive: true)
ArticlesRepository articlesRepository(Ref ref) {
  return ArticlesRepository(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
LanguagesRepository languagesRepository(Ref ref) {
  return LanguagesRepository();
}

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  return AuthService(
    dio: ref.watch(dioProvider),
    tokens: ref.watch(tokenStorageProvider),
  );
}

@Riverpod(keepAlive: true)
FCMService fcmService(Ref ref) {
  return FCMService(ref);
}

@Riverpod(keepAlive: true)
AppRouterHost appRouter(Ref ref) => throw UnimplementedError();
