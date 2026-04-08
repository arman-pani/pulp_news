import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';

class NoObjectsPlaceholder extends StatelessWidget {
  final String? subTitle;
  final String title;
  final IconData icon;
  const NoObjectsPlaceholder({
    super.key,
    this.subTitle,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              subTitle ?? AppStrings.checkBackLater,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
