import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/constants/app_textstyles.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/utils/app_router.dart';
import 'package:odiya_news_app/utils/helper_methods.dart';

class TreadingNews extends StatelessWidget {
  final List<NewsModel> trendingNews;
  const TreadingNews({super.key, required this.trendingNews});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.trendingNews, style: AppTextStyles.headline),
        SizedBox(
          height: 150,
          child: ListView.separated(
            itemCount: trendingNews.length,
            shrinkWrap: true,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final news = trendingNews[index];
              return GestureDetector(
                onTap: () =>
                    context.pushNamed(AppRoutes.articleDetail, extra: news),
                child: TrendingNewsCard(news: news, index: index),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12.0),
          ),
        ),
      ],
    );
  }
}

class TrendingNewsCard extends StatelessWidget {
  const TrendingNewsCard({super.key, required this.news, required this.index});

  final NewsModel news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: BoxBorder.fromBorderSide(
          BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 1.0,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${index + 1}',
            style: AppTextStyles.headline.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            news.title,
            style: AppTextStyles.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${formatDate(news.publishedAt)} | ${news.sourceName}',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}