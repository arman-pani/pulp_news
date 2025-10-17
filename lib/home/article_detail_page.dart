import 'package:flutter/material.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/home/widgets/news_home_page.dart';

class ArticleDetailPage extends StatelessWidget {
  final NewsModel article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NewsHomePage(article: article, isBack: true));
  }
}
