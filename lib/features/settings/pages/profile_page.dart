import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/core/utils/helper_methods.dart';
import 'package:odiya_news_app/features/settings/widgets/settings_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SettingsTile> tiles = [
      SettingsTile(
        title: AppStrings.bookmarks,
        subtitle: AppStrings.bookmarksDescription,
        leadingIcon: Icons.bookmark_outline,
        onTap: () => context.push(AppRoutes.bookmark),
      ),
      SettingsTile(
        title: AppStrings.settings,
        subtitle: AppStrings.settingsDescription,
        leadingIcon: Icons.settings_rounded,
        onTap: () => context.push(AppRoutes.settings),
      ),
      SettingsTile(
        title: AppStrings.userFeedback,
        subtitle: AppStrings.userFeedbackDescription,
        leadingIcon: Icons.feedback_outlined,
        onTap: () => launchUrl(Uri.parse(AppStrings.userFeedbackUrl)),
      ),
      SettingsTile(
        title: AppStrings.aboutUs,
        subtitle: AppStrings.aboutUsDescription,
        leadingIcon: Icons.info_outline,
        onTap: () => launchSourceUrl(AppStrings.aboutUsUrl, context),
      ),
      SettingsTile(
        title: AppStrings.privacyPolicy,
        subtitle: AppStrings.privacyPolicyDescription,
        leadingIcon: Icons.privacy_tip_outlined,
        onTap: () => launchSourceUrl(AppStrings.privacyPolicyUrl, context),
      ),
    ];
    return SafeArea(
      top: false,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        itemCount: tiles.length,
        itemBuilder: (context, index) {
          return tiles[index];
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
