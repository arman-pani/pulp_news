import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:odiya_news_app/utils/app_router.dart';

Future<void> launchSourceUrl(String sourceUrl, BuildContext context) async {
  try {
    // Navigate to web view page instead of external browser
    context.pushNamed(
      AppRoutes.webView,
      queryParameters: {
        'url': sourceUrl,
        'title': 'Source Article',
      },
    );
  } catch (e) {
    debugPrint('${AppStrings.urlLaunchError}: $e');
    Get.snackbar(
      AppStrings.error,
      AppStrings.cannotOpenUrl,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}

void shareArticle(NewsModel article) {
  final shareText = '''
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