import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/utils/app_router.dart';
import 'package:odiya_news_app/utils/helper_methods.dart';
import 'package:odiya_news_app/profile/widgets/settings_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Row(
          spacing: 8.0,
          children: [
            Icon(
              Icons.account_circle_rounded,
              size: 32.0,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            Text(
              AppStrings.profile,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookmarkPage(context),
              const Divider(),
              _buildSettings(context),
              const Divider(),
              _buildAboutUs(context),
              // const Divider(),
              // _buildHelpSupport(context),
              const Divider(),
              _buildPrivacyPolicy(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return SettingsTile(
      leadingIcon: Icons.settings_rounded,
      title: AppStrings.settings,
      subtitle: AppStrings.settingsDescription,
      onTap: () => context.pushNamed(AppRoutes.settings),
    );
  }

  Widget _buildBookmarkPage(BuildContext context) {
    return SettingsTile(
      leadingIcon: Icons.bookmark_outline,
      title: AppStrings.bookmarks,
      subtitle: AppStrings.bookmarksDescription,
      onTap: () => context.pushNamed(AppRoutes.bookmark),
    );
  }

  Widget _buildAboutUs(BuildContext context) {
    return SettingsTile(
      leadingIcon: Icons.info_outline,
      title: AppStrings.aboutUs,
      subtitle: AppStrings.aboutUsDescription,
      onTap: () => launchSourceUrl(
        AppStrings.aboutUsUrl,
        context,
      ),
    );
  }

  // Widget _buildHelpSupport(BuildContext context) {
  //   return SettingsTile(
  //     leadingIcon: Icons.help_outline,
  //     title: AppStrings.helpSupport,
  //     subtitle: 'Get help and contact support',
  //     onTap: () => _showHelpSupportDialog(context),
  //   );
  // }

  Widget _buildPrivacyPolicy(BuildContext context) {
    return SettingsTile(
      leadingIcon: Icons.privacy_tip_outlined,
      title: AppStrings.privacyPolicy,
      subtitle: AppStrings.privacyPolicyDescription,
      onTap: () => launchSourceUrl(
        AppStrings.privacyPolicyUrl,
        context,
      ),
    );
  }
}
