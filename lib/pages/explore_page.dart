import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/controllers/explore_controller.dart';
import 'package:odiya_news_app/utils/app_router.dart';
import 'package:odiya_news_app/widgets/no_articles_placeholder.dart';
import 'package:odiya_news_app/widgets/trending_news.dart';
import 'package:odiya_news_app/widgets/category_news_tabview.dart';
import 'package:odiya_news_app/widgets/try_again_placeholder.dart';
import 'package:odiya_news_app/widgets/search_bar.dart' as custom;

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ExploreController>(
        init: ExploreController(),
        builder: (ctrl) {
          // Show loading state
          if (ctrl.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error state
          if (ctrl.hasError) {
            return TryAgainPlaceholder(onRetry: ctrl.loadBundledArticles);
          }

          return DefaultTabController(
            length: ctrl.categories.length,
            child: CustomScrollView(
              slivers: [
                // Search Bar
                SliverToBoxAdapter(
                  child: custom.CustomSearchBar(
                    readOnly: true,
                    onTap: () {
                      // Navigate to search page when search bar is tapped
                      context.pushNamed(AppRoutes.search);
                    },
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),

                // Trending News Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      left: 16.0,
                      bottom: 16.0,
                    ),
                    child: TreadingNews(trendingNews: ctrl.trendingNews),
                  ),
                ),

                // Category Tabs
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                    child: TabBar(
                      dividerColor: Theme.of(context).colorScheme.outline,
                      splashFactory: NoSplash.splashFactory,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: ctrl.categories
                          .map((category) => Tab(text: category))
                          .toList(),
                    ),
                  ),
                ),

                // Category Content
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TabBarView(
                      children: ctrl.categories
                          .map(
                            (category) =>
                                _buildCategoryContent(context, ctrl, category),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryContent(
    BuildContext context,
    ExploreController ctrl,
    String category,
  ) {
    final articles = ctrl.getCategoryArticles(category);

    if (articles.isEmpty) {
      return NoArticlesPlaceholder();
    }

    return CategoryNewsTabView(newsList: articles, categoryName: category);
  }
}
