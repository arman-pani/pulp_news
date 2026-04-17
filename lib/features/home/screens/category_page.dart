import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/widgets/try_again_placeholder.dart';
import 'package:odiya_news_app/features/home/controllers/category_controller.dart';
import 'package:odiya_news_app/features/home/widgets/news_card.dart';
import 'package:odiya_news_app/core/widgets/no_objects_placeholder.dart';

class CategoryPage extends ConsumerWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryControllerProvider(categoryName));
    final controller = ref.read(
      categoryControllerProvider(categoryName).notifier,
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          categoryName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: categoryState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => TryAgainPlaceholder(
            onRetry: () =>
                ref.invalidate(categoryControllerProvider(categoryName)),
          ),
          data: (state) {
            if (state.articles.isEmpty) {
              return NoObjectsPlaceholder(
                title: AppStrings.noArticles,
                icon: Icons.article_outlined,
                subTitle: AppStrings.checkBackLater,
              );
            }

            final totalItemCount =
                state.articles.length +
                (state.isLoadingMore && state.articles.isNotEmpty ? 1 : 0);

            return RefreshIndicator(
              onRefresh: controller.refreshArticles,
              child: ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(12.0),
                itemCount: totalItemCount,
                itemBuilder: (context, index) {
                  if (index == state.articles.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final article = state.articles[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: NewsCard(newsModel: article),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
