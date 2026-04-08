import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/features/settings/controllers/settings_service.dart';
import 'package:odiya_news_app/features/settings/widgets/settings_tile.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsServiceProvider);
    final settingsService = ref.read(settingsServiceProvider.notifier);
    final isDark = settingsState.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          AppStrings.settings,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        children: [
          SettingsTile(
            leadingIcon: isDark ? Icons.dark_mode : Icons.light_mode,
            title: AppStrings.themeSettings,
            subtitle: isDark ? AppStrings.darkTheme : AppStrings.lightTheme,
            trailing: Switch(
              value: isDark,
              onChanged: (value) => settingsService.toggleTheme(),
              activeThumbColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          SettingsTile(
            leadingIcon: Icons.language,
            title: AppStrings.selectLanguage,
            subtitle: settingsService.languageDisplayName,
            onTap: () => context.pushNamed(AppRoutes.language),
          ),
          SettingsTile(
            leadingIcon: settingsState.notificationsEnabled
                ? Icons.notifications
                : Icons.notifications_off,
            title: AppStrings.notificationSettings,
            subtitle: AppStrings.notificationSettings,
            trailing: Switch(
              value: settingsState.notificationsEnabled,
              onChanged: settingsState.isUpdatingNotifications
                  ? null
                  : (value) => settingsService.toggleNotifications(value),
              activeThumbColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
