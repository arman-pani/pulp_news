import 'package:flutter/material.dart';
import 'package:odiya_news_app/features/feed/widgets/article_image_box.dart';
import 'package:odiya_news_app/features/feed/widgets/content_column.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/features/feed/widgets/banner_ad_widget.dart';

class NewsCard extends StatelessWidget {
  final NewsModel article;
  final bool isBack;
  final bool showBannerAd;

  const NewsCard({
    super.key,
    required this.article,
    this.isBack = false,
    this.showBannerAd = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ArticleImageBox(isBack: isBack, article: article),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ContentColumn(article: article),
          ),
        ),
        if (showBannerAd)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: BannerAdWidget(key: ValueKey('banner-${article.id}')),
          ),
      ],
    );
  }
}
