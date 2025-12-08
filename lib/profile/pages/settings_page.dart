import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/services/settings_service.dart';
import 'package:odiya_news_app/profile/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingsService settingsService = SettingsService.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          AppStrings.settings,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Column(
          children: [
            _buildLanguageSelector(context, settingsService),
            const Divider(),
            _buildThemeToggle(context, settingsService),  
            const Divider(),
            _buildNotificationToggle(context, settingsService),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(
    BuildContext context,
    SettingsService settingsService,
  ) {
    return Obx(() {
      final isDark = settingsService.isDarkMode;

      return SettingsTile(
        leadingIcon: isDark ? Icons.dark_mode : Icons.light_mode,
        title: AppStrings.themeSettings,
        subtitle: isDark ? AppStrings.darkTheme : AppStrings.lightTheme,
        trailing: Switch(
          value: isDark,
          onChanged: (value) => settingsService.toggleTheme(),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      );
    });
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    SettingsService settingsService,
  ) {
    return Obx(() => SettingsTile(
      leadingIcon: Icons.language,
      title: AppStrings.selectLanguage,
      subtitle: settingsService.languageDisplayName,
      onTap: () => _showLanguageDialog(context, settingsService),
    ));
  }

  Widget _buildNotificationToggle(
    BuildContext context,
    SettingsService settingsService,
  ) {
    return Obx(
      () => SettingsTile(
        leadingIcon: settingsService.notificationsEnabled ? Icons.notifications : Icons.notifications_off,
        title: AppStrings.notificationSettings,
        subtitle: AppStrings.notificationSettings,
        trailing: Switch(
          value: settingsService.notificationsEnabled,
          onChanged: (value) => settingsService.toggleNotifications(value, context),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    SettingsService settingsService,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppStrings.selectLanguage,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text(
                AppStrings.english,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              value: 'en',
              groupValue: settingsService.selectedLanguage,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                if (value != null) {
                  settingsService.changeLanguage(value);
                  Navigator.of(context).pop();
                }
              },
            ),
            // RadioListTile<String>(
            //   title: Text(
            //     AppStrings.odia,
            //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //       color: Theme.of(context).colorScheme.onSurface,
            //     ),
            //   ),
            //   value: 'odia',
            //   groupValue: settingsService.selectedLanguage,
            //   activeColor: Theme.of(context).colorScheme.primary,
            //   onChanged: (value) {
            //     if (value != null) {
            //       settingsController.changeLanguage(value);
            //       Navigator.of(context).pop();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
