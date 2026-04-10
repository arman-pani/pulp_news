import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/widgets/try_again_placeholder.dart';
import 'package:odiya_news_app/features/home/controllers/explore_controller.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/features/home/widgets/trending_news.dart';
import 'package:odiya_news_app/features/home/widgets/category_news_tabview.dart';
import 'package:odiya_news_app/features/home/widgets/custom_search_bar.dart';
import 'package:odiya_news_app/core/widgets/no_objects_placeholder.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateToSearch() => context.push(AppRoutes.search);
    final exploreState = ref.watch(exploreControllerProvider);

    return SafeArea(
      child: exploreState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => TryAgainPlaceholder(
          onRetry: () => ref.invalidate(exploreControllerProvider),
        ),
        data: (state) {
          if (state.categoryArticles.isEmpty) {
            debugPrint("categoryArticles is empty");
            return NoObjectsPlaceholder(
              title: AppStrings.noArticles,
              icon: Icons.article_outlined,
              subTitle: AppStrings.checkBackLater,
            );
          }

          return DefaultTabController(
            length: state.categories.length,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CustomSearchBar(
                    readOnly: true,
                    onTap: navigateToSearch,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      left: 16.0,
                      bottom: 16.0,
                    ),
                    child: TreadingNews(trendingNews: state.trendingNews),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                    child: TabBar(
                      dividerColor: Theme.of(context).colorScheme.outline,
                      splashFactory: NoSplash.splashFactory,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: state.categories
                          .map((category) => Tab(text: category))
                          .toList(),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CategoriesTabView(state: state),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
