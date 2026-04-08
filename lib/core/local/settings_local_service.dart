import 'package:odiya_news_app/core/local/hive_service.dart';

class SettingsLocalService {
  SettingsLocalService(this._hiveService);

  static const isDarkModeKey = 'isDarkMode';
  static const languageKey = 'language';
  static const onboardingCompletedKey = 'onboardingCompleted';

  final HiveService _hiveService;

  Future<void> setThemeMode(bool isDark) async {
    await _hiveService.settingsBox.put(isDarkModeKey, isDark.toString());
  }

  bool getThemeMode() {
    final value = _hiveService.settingsBox.get(
      isDarkModeKey,
      defaultValue: 'false',
    );
    return value == 'true';
  }

  Future<void> setLanguage(String language) async {
    await _hiveService.settingsBox.put(languageKey, language);
  }

  String getLanguage() {
    return _hiveService.settingsBox.get(languageKey, defaultValue: 'en') ?? 'en';
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    await _hiveService.settingsBox.put(
      onboardingCompletedKey,
      completed.toString(),
    );
  }

  bool getOnboardingCompleted() {
    final value = _hiveService.settingsBox.get(
      onboardingCompletedKey,
      defaultValue: 'false',
    );
    return value == 'true';
  }
}
