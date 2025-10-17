import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/constants/app_theme.dart';
import 'package:odiya_news_app/services/hive_service.dart';
import 'package:odiya_news_app/services/fcm_service.dart';

class SettingsController extends GetxService {
  static SettingsController get to => Get.find();
  final hiveService = Get.find<HiveService>();
  // Theme related observables
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  ThemeMode get themeMode => _themeMode.value;
  
  final Rx<Brightness> _brightness = Brightness.light.obs;
  Brightness get brightness => _brightness.value;
  
  bool get isDarkMode => _brightness.value == Brightness.dark;
  
  // Observable variables for GetX
  Rx<ThemeMode> get themeModeObs => _themeMode;
  Rx<Brightness> get brightnessObs => _brightness;
  
  // Settings observables
  final RxString _selectedLanguage = 'en'.obs;
  String get selectedLanguage => _selectedLanguage.value;
  
  // Notification observables
  final RxBool _notificationsEnabled = true.obs;
  bool get notificationsEnabled => _notificationsEnabled.value;
  
  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }
  
  // Load all settings from storage
  void _loadSettings() {
    _loadThemeFromStorage();
    _loadLanguageFromStorage();
    _loadNotificationSettings();
  }
  
  // Theme methods
  void _loadThemeFromStorage() {
    final isDark = hiveService.getThemeMode();
    _setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }
  
  void _setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    _brightness.value = mode == ThemeMode.dark ? Brightness.dark : Brightness.light;
  }
  
  void toggleTheme() {
    final newMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _setThemeMode(newMode);
    _saveThemeToStorage();
  }
  
  void setThemeMode(ThemeMode mode) {
    _setThemeMode(mode);
    _saveThemeToStorage();
  }
  
  void _saveThemeToStorage() {
    hiveService.setThemeMode(isDarkMode);
  }
  
  // Language methods
  void _loadLanguageFromStorage() {
    _selectedLanguage.value = hiveService.getLanguage();
  }
  
  void _loadNotificationSettings() {
    _notificationsEnabled.value = hiveService.getNotificationEnabled();
  }
  
  void changeLanguage(String language) async {
    _selectedLanguage.value = language;
    await hiveService.setLanguage(language);
    // Note: Language switching would need to be implemented with localization
  }
  
  // Notification methods
  void toggleNotifications(bool value, BuildContext context) {
    // Update UI immediately for better user experience
    _notificationsEnabled.value = value;
    
    // Handle backend operation asynchronously
    _handleNotificationToggle(value, context);
  }
  
  Future<void> _handleNotificationToggle(bool value, BuildContext context) async {
    try {
      final success = await FCMService.to.toggleNotifications(value);
      if (!success) {
        // Revert UI state if backend operation failed
        _notificationsEnabled.value = !value;
        _showErrorSnackBar(context);
      }
    } catch (e) {
      // Revert UI state if backend operation failed
      _notificationsEnabled.value = !value;
      _showErrorSnackBar(context);
    }
  }
  
  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Failed to update notification settings. Please try again.'),
        backgroundColor: Theme.of(context).colorScheme.error,
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () => toggleNotifications(_notificationsEnabled.value, context),
        ),
      ),
    );
  }
  
  // Theme data getters
  ThemeData get currentTheme {
    return isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  }
  
  ThemeData getThemeData(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return AppTheme.lightTheme;
      case ThemeMode.dark:
        return AppTheme.darkTheme;
      case ThemeMode.system:
        return AppTheme.lightTheme; // Default to light theme
    }
  }
  
  // Language display helpers
  String get languageDisplayName {
    switch (_selectedLanguage.value) {
      case 'en':
        return 'English';
      case 'odia':
        return 'Odia';
      default:
        return 'English';
    }
  }
  
  // Notification display helpers
  String get notificationStatus {
    return notificationsEnabled ? 'Enabled' : 'Disabled';
  }
  
  IconData get notificationIcon {
    return notificationsEnabled 
        ? Icons.notifications 
        : Icons.notifications_off;
  }
}
