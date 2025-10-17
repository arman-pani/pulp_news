import 'package:flutter/material.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/search/search_controller.dart';
import 'package:odiya_news_app/widgets/news_card.dart';

class SearchResults extends StatelessWidget {
  final NewsSearchController ctrl;
  const SearchResults({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    if (ctrl.shouldShowLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (ctrl.shouldShowError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
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
                AppStrings.searchError,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ctrl.searchErrorMessage ?? AppStrings.tryAgain,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final query = ctrl.searchController.text;
                  if (query.isNotEmpty) {
                    ctrl.searchArticles(query);
                  }
                },
                child: Text(AppStrings.tryAgain),
              ),
            ],
          ),
        ),
      );
    }

    if (ctrl.shouldShowEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.noSearchResults,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.tryDifferentKeywords,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        final query = ctrl.searchController.text;
        if (query.isNotEmpty) {
          ctrl.searchArticles(query);
        }
      },
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: ctrl.searchResults.length,
        itemBuilder: (context, index) {
          final article = ctrl.searchResults[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: NewsCard(newsModel: article),
          );
        },
      ),
    );
  }
}
