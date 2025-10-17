import 'package:flutter/material.dart';
import 'package:odiya_news_app/constants/app_strings.dart';

class TryAgainPlaceholder extends StatelessWidget {
  final VoidCallback onRetry;
  final String? errorMessage;
  const TryAgainPlaceholder({super.key, required this.onRetry, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.failedToLoadArticles,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage ?? AppStrings.pleaseTryAgainLater,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}