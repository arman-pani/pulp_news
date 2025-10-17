import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/utils/app_router.dart';
import 'package:odiya_news_app/widgets/news_list_tile.dart';

class CategoryNewsTabView extends StatelessWidget {
  final List<NewsModel> newsList;
  final String categoryName;
  const CategoryNewsTabView({super.key, required this.newsList, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        debugPrint(news.toString());
        return Column(
          spacing: 16.0,
          children: [
            NewsListTile(news: news),
            if (index == newsList.length - 1) _buildShowMoreButton(context, news),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
    );
  }

  Widget _buildShowMoreButton(BuildContext context, NewsModel news) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.pushNamed(
            AppRoutes.category,
            pathParameters: {'categoryName': Uri.encodeComponent(categoryName)},
          );
        },
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: IconAlignment.end,
        label: Text(AppStrings.showMore),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }
}