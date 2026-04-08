import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/features/onboarding/models/language_option.dart';
import 'package:odiya_news_app/features/settings/controllers/settings_service.dart';

part 'language_controller.freezed.dart';
part 'language_controller.g.dart';

@freezed
class LanguageScreenState with _$LanguageScreenState {
  const factory LanguageScreenState({
    @Default(<LanguageOption>[]) List<LanguageOption> languages,
    String? selectedLanguageCode,
    @Default(false) bool isSubmitting,
  }) = _LanguageScreenState;
}

@Riverpod(keepAlive: true)
class LanguageController extends _$LanguageController {
  @override
  Future<LanguageScreenState> build() async {
    final languages = await ref
        .watch(languagesRepositoryProvider)
        .fetchAvailableLanguages();

    return LanguageScreenState(
      languages: languages,
      selectedLanguageCode: ref
          .read(settingsLocalServiceProvider)
          .getLanguage(),
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
      await ref
          .read(settingsServiceProvider.notifier)
          .changeLanguage(selectedLanguageCode);

      final authService = ref.read(authServiceProvider);
      if (!authService.hasSession) {
        await authService.refreshSession();
      }

      ref.read(appRouterProvider).router.goNamed(AppRoutes.explore);
      _initializeDeferredFcm();
      state = AsyncData(currentState.copyWith(isSubmitting: false));
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
