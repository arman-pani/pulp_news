import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odiya_news_app/features/feed/controllers/feed_controller.dart';
import 'package:odiya_news_app/features/feed/widgets/news_card.dart';
import 'package:odiya_news_app/core/widgets/seen_all_articles_placeholder.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(feedControllerProvider);
    final controller = ref.read(feedControllerProvider.notifier);

    return homeState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => _buildEmptyState(
        controller,
        homeState.valueOrNull ?? const FeedScreenState(),
      ),
      data: (state) {
        if (state.articles.isEmpty) {
          return _buildEmptyState(controller, state);
        }

        return PageView.builder(
          controller: controller.pageController,
          scrollDirection: Axis.vertical,
          itemCount: state.articles.length + (state.noMoreArticles ? 1 : 0),
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) =>
              _buildPageItem(controller, state, index),
        );
      },
    );
  }

  Widget _buildEmptyState(FeedController controller, FeedScreenState state) {
    if (state.noMoreArticles || !state.isLoading) {
      return SeenAllArticlesPlaceholder(onRefresh: controller.refreshArticles);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildPageItem(
    FeedController controller,
    FeedScreenState state,
    int index,
  ) {
    if (state.noMoreArticles && index == state.articles.length) {
      return SeenAllArticlesPlaceholder(onRefresh: controller.refreshArticles);
    }

    return NewsCard(article: state.articles[index]);
  }
}
