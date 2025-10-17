import 'package:flutter/material.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/search/search_controller.dart';

class RecentSearches extends StatelessWidget {
  final NewsSearchController ctrl;
  const RecentSearches({super.key, required this.ctrl});

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
              if (ctrl.recentSearches.isNotEmpty)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: ctrl.clearRecentSearches,
                  icon: Icon(Icons.delete, size: 16),
                ),
            ],
          ),
        ),
        ctrl.recentSearches.isEmpty
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
                itemCount: ctrl.recentSearches.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final search = ctrl.recentSearches[index];
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(search),
                    onTap: () {
                      ctrl.searchController.text = search;
                      ctrl.searchArticles(search);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        // Remove from recent searches
                        ctrl.recentSearches.remove(search);
                        ctrl.update();
                      },
                    ),
                  );
                },
              ),
      ],
    );
  }
}
