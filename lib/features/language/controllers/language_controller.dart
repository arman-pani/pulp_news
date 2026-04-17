import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/features/feed/controllers/feed_controller.dart';
import 'package:odiya_news_app/features/home/controllers/home_controller.dart';
import 'package:odiya_news_app/features/language/models/language_option.dart';
import 'package:odiya_news_app/features/search/controllers/search_controller.dart';
import 'package:odiya_news_app/features/settings/controllers/settings_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_controller.freezed.dart';
part 'language_controller.g.dart';

@freezed
class LanguageScreenState with _$LanguageScreenState {
  const factory LanguageScreenState({
    @Default(<LanguageOption>[]) List<LanguageOption> languages,
    String? currentLanguageCode,
    String? selectedLanguageCode,
    @Default(false) bool isSubmitting,
  }) = _LanguageScreenState;
}

@Riverpod(keepAlive: true)
class LanguageController extends _$LanguageController {
  @override
  Future<LanguageScreenState> build() async {
    final settingsLocalService = ref.read(settingsLocalServiceProvider);
    final languages = await ref
        .watch(languagesRepositoryProvider)
        .fetchAvailableLanguages();
    final currentLanguageCode = settingsLocalService.getLanguageCode();

    return LanguageScreenState(
      languages: languages,
      currentLanguageCode: currentLanguageCode,
      selectedLanguageCode: currentLanguageCode,
    );
  }

  void syncSelectionWithPersistedLanguage() {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.isSubmitting) {
      return;
    }

    final persistedLanguageCode = ref
        .read(settingsLocalServiceProvider)
        .getLanguageCode();
    state = AsyncData(
      currentState.copyWith(
        currentLanguageCode: persistedLanguageCode,
        selectedLanguageCode: persistedLanguageCode,
      ),
    );
  }

  void selectLanguage(String languageCode) {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.isSubmitting) {
      return;
    }

    state = AsyncData(
      currentState.copyWith(selectedLanguageCode: languageCode),
    );
  }

  Future<void> confirmLanguageChange() async {
    final currentState = state.valueOrNull;
    final selectedLanguageCode = currentState?.selectedLanguageCode;
    final currentLanguageCode = currentState?.currentLanguageCode;

    if (currentState == null ||
        currentState.isSubmitting ||
        selectedLanguageCode == null ||
        currentLanguageCode == null ||
        selectedLanguageCode == currentLanguageCode) {
      return;
    }

    state = AsyncData(currentState.copyWith(isSubmitting: true));

    try {
      final notificationsLocalService = ref.read(
        notificationsLocalServiceProvider,
      );
      final fcmService = ref.read(fcmServiceProvider);
      final notificationsEnabled = notificationsLocalService
          .getNotificationEnabled();

      if (notificationsEnabled) {
        await fcmService.unsubscribeFromLanguageTopic(currentLanguageCode);
        await fcmService.subscribeToLanguageTopic(selectedLanguageCode);
      }

      final settingsLocalService = ref.read(settingsLocalServiceProvider);
      await settingsLocalService.setLanguage(selectedLanguageCode);
      await ref.read(articlesLocalServiceProvider).clearArticles();
      await notificationsLocalService.clearPendingNotificationArticles();

      ref.invalidate(settingsServiceProvider);
      ref.invalidate(feedControllerProvider);
      ref.invalidate(homeControllerProvider);
      ref.invalidate(searchControllerProvider);

      state = AsyncData(
        currentState.copyWith(
          currentLanguageCode: selectedLanguageCode,
          selectedLanguageCode: selectedLanguageCode,
          isSubmitting: false,
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncData(currentState.copyWith(isSubmitting: false));
      ref
          .read(appSnackbarServiceProvider)
          .showError('Failed to update language. Please try again.');
      FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace),
      );
    }
  }

  Future<void> completeSetup() async {
    final currentState = state.valueOrNull;
    final selectedLanguageCode = currentState?.selectedLanguageCode;

    if (currentState == null ||
        currentState.isSubmitting ||
        selectedLanguageCode == null) {
      if (selectedLanguageCode == null) {
        ref
            .read(appSnackbarServiceProvider)
            .showError(AppStrings.selectLanguageToContinue);
      }
      return;
    }

    state = AsyncData(currentState.copyWith(isSubmitting: true));

    try {
      final settingsLocalService = ref.read(settingsLocalServiceProvider);
      await settingsLocalService.setLanguage(selectedLanguageCode);
      await settingsLocalService.setOnboardingCompleted(true);

      final authService = ref.read(authServiceProvider);
      if (!authService.hasSession) {
        await authService.refreshSession();
      }

      ref.read(appRouterProvider).router.go(AppRoutes.home);
      _initializeDeferredFcm();
      state = AsyncData(
        currentState.copyWith(
          currentLanguageCode: selectedLanguageCode,
          selectedLanguageCode: selectedLanguageCode,
          isSubmitting: false,
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncData(currentState.copyWith(isSubmitting: false));
      ref
          .read(appSnackbarServiceProvider)
          .showError('Failed to complete setup. Please try again.');
      FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace),
      );
    }
  }

  void _initializeDeferredFcm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fcmServiceProvider).requestPermissionDeferred();
    });
  }
}
