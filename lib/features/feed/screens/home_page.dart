import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:odiya_news_app/features/feed/controllers/home_controller.dart';
import 'package:odiya_news_app/features/feed/widgets/news_card.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/widgets/native_ad_widget.dart';
import 'package:odiya_news_app/core/widgets/seen_all_articles_placeholder.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final controller = ref.read(homeControllerProvider.notifier);

    return homeState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => _buildEmptyState(
        controller,
        homeState.valueOrNull ?? const HomeScreenState(),
      ),
      data: (state) {
        final displayList = controller.displayList;
        if (displayList.isEmpty) {
          return _buildEmptyState(controller, state);
        }

        return PageView.builder(
          controller: controller.pageController,
          scrollDirection: Axis.vertical,
          itemCount: displayList.length + (state.noMoreArticles ? 1 : 0),
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) =>
              _buildPageItem(controller, state, displayList, index),
        );
      },
    );
  }

  Widget _buildEmptyState(HomeController controller, HomeScreenState state) {
    if (state.noMoreArticles || !state.isLoading) {
      return SeenAllArticlesPlaceholder(onRefresh: controller.refreshArticles);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildPageItem(
    HomeController controller,
    HomeScreenState state,
    List<dynamic> displayList,
    int index,
  ) {
    if (state.noMoreArticles && index == displayList.length) {
      return SeenAllArticlesPlaceholder(onRefresh: controller.refreshArticles);
    }

    if (displayList[index] is NativeAd) {
      return NativeAdWidget(nativeAd: displayList[index] as NativeAd);
    }

    final article = displayList[index];
    if (article is NewsModel) {
      return NewsCard(article: article);
    }

    return const Center(child: CircularProgressIndicator());
  }
}
