import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odiya_news_app/core/constants/app_theme.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';

part 'settings_service.freezed.dart';
part 'settings_service.g.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required ThemeMode themeMode,
    required Brightness brightness,
    required String selectedLanguage,
    required bool notificationsEnabled,
    @Default(false) bool isUpdatingNotifications,
  }) = _SettingsState;
}

@Riverpod(keepAlive: true)
class SettingsService extends _$SettingsService {
  @override
  SettingsState build() {
    final settingsLocalService = ref.watch(settingsLocalServiceProvider);
    final notificationsLocalService = ref.watch(
      notificationsLocalServiceProvider,
    );
    final isDark = settingsLocalService.getThemeMode();

    return SettingsState(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      brightness: isDark ? Brightness.dark : Brightness.light,
      selectedLanguage: settingsLocalService.getLanguageDisplayName(),
      notificationsEnabled: notificationsLocalService.getNotificationEnabled(),
    );
  }

  bool get isDarkMode => state.brightness == Brightness.dark;

  ThemeData get currentTheme =>
      isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() {
    final newMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    setThemeMode(newMode);
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(
      themeMode: mode,
      brightness: mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
    );
    ref.read(settingsLocalServiceProvider).setThemeMode(mode == ThemeMode.dark);
  }

  Future<void> toggleNotifications(bool value) async {
    final previousValue = state.notificationsEnabled;
    state = state.copyWith(
      notificationsEnabled: value,
      isUpdatingNotifications: true,
    );

    try {
      final success = await ref
          .read(fcmServiceProvider)
          .toggleNotifications(value);
      if (!success) {
        state = state.copyWith(
          notificationsEnabled: previousValue,
          isUpdatingNotifications: false,
        );
        _showNotificationError();
        return;
      }
    } catch (_) {
      state = state.copyWith(
        notificationsEnabled: previousValue,
        isUpdatingNotifications: false,
      );
      _showNotificationError();
      return;
    }

    state = state.copyWith(isUpdatingNotifications: false);
  }

  void _showNotificationError() {
    ref
        .read(appSnackbarServiceProvider)
        .showError('Failed to update notification settings. Please try again.');
  }

  String get notificationStatus =>
      state.notificationsEnabled ? 'Enabled' : 'Disabled';

  IconData get notificationIcon => state.notificationsEnabled
      ? Icons.notifications
      : Icons.notifications_off;
}
