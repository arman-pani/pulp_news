import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({
    super.key,
    required this.recentSearches,
    required this.onClearAll,
    required this.onTapSearch,
  });

  final List<String> recentSearches;
  final VoidCallback onClearAll;
  final ValueChanged<String> onTapSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.recentSearches,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              if (recentSearches.isNotEmpty)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: onClearAll,
                  icon: const Icon(Icons.delete, size: 16),
                ),
            ],
          ),
        ),
        recentSearches.isEmpty
            ? Center(
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
                        AppStrings.noSearchHistory,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: recentSearches.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final search = recentSearches[index];
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(
                      search,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () => onTapSearch(search),
                  );
                },
              ),
      ],
    );
  }
}
