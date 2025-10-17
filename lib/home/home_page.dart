import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:odiya_news_app/home/home_controller.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/widgets/native_ad_widget.dart';
import 'package:odiya_news_app/home/widgets/news_home_page.dart';
import 'package:odiya_news_app/widgets/seen_all_articles_placeholder.dart';
import 'package:odiya_news_app/widgets/try_again_placeholder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (ctrl) {
          return _buildContent(ctrl);
        },
      ),
    );
  }

  Widget _buildContent(HomeController ctrl) {
    // Handle empty states
    if (ctrl.displayList.isEmpty) {
      return _buildEmptyState(ctrl);
    }

    return PageView.builder(
      controller: ctrl.pageController,
      scrollDirection: Axis.vertical,
      itemCount: ctrl.displayList.length + (ctrl.noMoreArticles ? 1 : 0),
      onPageChanged: ctrl.onPageChanged,
      itemBuilder: (context, index) => _buildPageItem(ctrl, index),
    );
  }

  Widget _buildEmptyState(HomeController ctrl) {
    if (ctrl.shouldShowError) return TryAgainPlaceholder(onRetry: ctrl.refreshArticles);
    if (ctrl.noMoreArticles) return SeenAllArticlesPlaceholder(onRefresh: ctrl.refreshArticles);
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildPageItem(HomeController ctrl, int index) {
    // Show "seen all" placeholder at the end
    if (ctrl.noMoreArticles && index == ctrl.displayList.length) {
      return SeenAllArticlesPlaceholder(onRefresh: ctrl.refreshArticles);
    }

    // Handle ads
    if (ctrl.displayList[index] is NativeAd) {
      return NativeAdWidget(nativeAd: ctrl.displayList[index] as NativeAd);
    }

    // Handle articles
    final article = ctrl.displayList[index];
    if (article is NewsModel) {
      return NewsHomePage(article: article);
    }

    // Fallback
    return const Center(child: CircularProgressIndicator());
  }
}