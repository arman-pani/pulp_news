import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/controllers/category_controller.dart';
import 'package:odiya_news_app/widgets/news_card.dart';
import 'package:odiya_news_app/widgets/no_articles_placeholder.dart';
import 'package:odiya_news_app/widgets/try_again_placeholder.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
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
      body: GetBuilder<CategoryController>(
        init: CategoryController(categoryName: categoryName),
        builder: (ctrl) {
          // Show loading indicator for initial load
          if (ctrl.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error state
          if (ctrl.hasError) {
            return TryAgainPlaceholder(onRetry: ctrl.refreshArticles);
          }

          // Show empty state
          if (ctrl.isEmpty) {
            return NoArticlesPlaceholder();
          }

          // Show articles list
          return RefreshIndicator(
            onRefresh: () => ctrl.refreshArticles(),
            child: ListView.builder(
              controller: ctrl.scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: ctrl.totalItemCount,
              itemBuilder: (context, index) {
                // Show loading indicator at the bottom when loading more
                if (index == ctrl.categoryArticles.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final article = ctrl.categoryArticles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: NewsCard(newsModel: article),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
