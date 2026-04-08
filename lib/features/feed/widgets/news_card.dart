import 'package:flutter/material.dart';
import 'package:odiya_news_app/features/feed/widgets/article_image_box.dart';
import 'package:odiya_news_app/features/feed/widgets/content_column.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/features/feed/widgets/banner_ad_widget.dart';

class NewsCard extends StatelessWidget {
  final NewsModel article;
  final bool isBack;
  const NewsCard({super.key, required this.article, this.isBack = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ArticleImageBox(isBack: isBack, article: article),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ContentColumn(article: article),
        ),
        const Spacer(),
        BannerAdWidget(),
        SizedBox(height: 16),
      ],
    );
  }
}
