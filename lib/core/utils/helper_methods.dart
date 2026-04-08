import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/utils/dialogs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

Future<void> checkAppVersion(BuildContext context) async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.fetchAndActivate();

  final latestVersion = remoteConfig.getString('latest_version');
  final latestBuild = remoteConfig.getInt('latest_build');
  final minSupportedBuild = remoteConfig.getInt('min_supported_build');

  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version; // e.g. "1.0.0"
  final currentBuild = int.parse(packageInfo.buildNumber); // e.g. 2

  debugPrint(
    'Current: $currentVersion+$currentBuild | Latest: $latestVersion+$latestBuild',
  );

  if (!context.mounted) return;

  if (currentBuild < minSupportedBuild) {
    showForceUpdateDialog(context, true);
  } else if (currentBuild < latestBuild) {
    showForceUpdateDialog(context, false);
  }
}

Future<void> launchSourceUrl(String sourceUrl, BuildContext context) async {
  try {
    // Navigate to web view page instead of external browser
    context.pushNamed(
      AppRoutes.webView,
      queryParameters: {'url': sourceUrl, 'title': 'Source Article'},
    );
  } catch (e) {
    debugPrint('${AppStrings.urlLaunchError}: $e');
    ProviderScope.containerOf(
      context,
      listen: false,
    ).read(appSnackbarServiceProvider).showError(AppStrings.cannotOpenUrl);
  }
}

void shareArticle(NewsModel article) {
  final shareText =
      '''
${article.title}

${article.content}

${AppStrings.readMore}: ${article.sourceUrl}

${AppStrings.sharedVia}
''';

  Share.share(shareText, subject: article.title);
}

String formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? AppStrings.daysAgo : AppStrings.daysAgo}';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? AppStrings.hoursAgo : AppStrings.hoursAgo}';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? AppStrings.minutesAgo : AppStrings.minutesAgo}';
  } else {
    return AppStrings.justNow;
  }
}
