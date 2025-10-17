import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/controllers/settings_controller.dart';
import 'package:odiya_news_app/profile/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingsController settingsController = Get.find();

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
            _buildLanguageSelector(context, settingsController),
            const Divider(),
            _buildThemeToggle(context, settingsController),
            const Divider(),
            _buildNotificationToggle(context, settingsController),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(
    BuildContext context,
    SettingsController settingsController,
  ) {
    return Obx(() {
      final isDark = settingsController.brightnessObs.value == Brightness.dark;
      
      return SettingsTile(
        leadingIcon: isDark ? Icons.dark_mode : Icons.light_mode,
        title: AppStrings.themeSettings,
        subtitle: isDark ? AppStrings.darkTheme : AppStrings.lightTheme,
        trailing: Switch(
          value: isDark,
          onChanged: (value) => settingsController.toggleTheme(),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      );
    });
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    SettingsController settingsController,
  ) {
    return Obx(() => SettingsTile(
      leadingIcon: Icons.language,
      title: AppStrings.selectLanguage,
      subtitle: settingsController.languageDisplayName,
      onTap: () => _showLanguageDialog(context, settingsController),
    ));
  }

  Widget _buildNotificationToggle(
    BuildContext context,
    SettingsController settingsController,
  ) {
    return Obx(
      () => SettingsTile(
        leadingIcon: settingsController.notificationIcon,
        title: AppStrings.notificationSettings,
        subtitle: settingsController.notificationStatus,
        trailing: Switch(
          value: settingsController.notificationsEnabled,
          onChanged: (value) => settingsController.toggleNotifications(value, context),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    SettingsController settingsController,
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
              groupValue: settingsController.selectedLanguage,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                if (value != null) {
                  settingsController.changeLanguage(value);
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
            //   groupValue: settingsController.selectedLanguage,
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
