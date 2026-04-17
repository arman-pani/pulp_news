import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/features/feed/widgets/news_card.dart';

class ArticleDetailPage extends StatelessWidget {
  final NewsModel article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: NewsCard(article: article, isBack: true),
      ),
    );
  }
}
