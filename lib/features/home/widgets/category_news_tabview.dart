import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/features/home/controllers/home_controller.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/widgets/news_list_tile.dart';
import 'package:odiya_news_app/core/widgets/no_objects_placeholder.dart';

class CategoriesTabView extends StatelessWidget {
  final HomeScreenState state;

  const CategoriesTabView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final categories = state.categories;
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(state.categories.length, (index) {
        final category = categories[index];
        final articles =
            state.categoryArticles[category] ?? const <NewsModel>[];
        return articles.isEmpty
            ? NoObjectsPlaceholder(
                title: AppStrings.noArticles,
                icon: Icons.article_outlined,
                subTitle: AppStrings.checkBackLater,
              )
            : CategoryTab(category: category, articles: articles);
      }),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String category;
  final List<NewsModel> articles;
  const CategoryTab({
    super.key,
    required this.category,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    void showMoreButton() => context.push(AppRoutes.category, extra: category);
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final news = articles[index];
        debugPrint(news.toString());
        return Column(
          spacing: 16.0,
          children: [
            NewsListTile(news: news),
            if (index == articles.length - 1)
              _buildShowMoreButton(showMoreButton, context),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
    );
  }

  Widget _buildShowMoreButton(VoidCallback onPressed, BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        minimumSize: const Size(double.infinity, 0),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
      ),
      child: Text(AppStrings.showMore, style: TextStyle(fontSize: 16)),
    );
  }
}
