import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/search/search_controller.dart';
import 'package:odiya_news_app/search/widgets/recent_searches.dart';
import 'package:odiya_news_app/search/widgets/search_results.dart';
import 'package:odiya_news_app/widgets/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Text(
          AppStrings.search,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: GetBuilder<NewsSearchController>(
        init: NewsSearchController(),
        builder: (ctrl) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CustomSearchBar(
                  controller: ctrl.searchController,
                  focusNode: ctrl.searchFocusNode,
                  hintText: AppStrings.searchHint,
                  onSubmitted: (query) {
                    if (query.trim().isNotEmpty) {
                      ctrl.searchArticles(query);
                    }
                  },
                  onClear: ctrl.clearSearch,
                  padding: const EdgeInsets.all(16.0),
                ),
              ),
              SliverToBoxAdapter(
                child: ctrl.shouldShowRecentSearches
                    ? RecentSearches(ctrl: ctrl)
                    : SearchResults(ctrl: ctrl),
              ),
            ],
          );
        },
      ),
    );
  }
}
