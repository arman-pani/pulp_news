import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/features/home/widgets/news_card.dart';
import 'package:odiya_news_app/features/search/controllers/search_controller.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  final SearchScreenState state;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (state.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!state.isSearching &&
        state.currentQuery.isNotEmpty &&
        state.searchResults.isEmpty) {
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
      onRefresh: onRefresh,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: state.searchResults.length,
        itemBuilder: (context, index) {
          final article = state.searchResults[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: NewsCard(newsModel: article),
          );
        },
      ),
    );
  }
}
