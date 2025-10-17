import 'package:flutter/material.dart';
import 'package:odiya_news_app/constants/app_strings.dart';

class NoArticlesPlaceholder extends StatelessWidget {
  final String? subTitle;
  const NoArticlesPlaceholder({super.key, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.article_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.noArticles,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
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