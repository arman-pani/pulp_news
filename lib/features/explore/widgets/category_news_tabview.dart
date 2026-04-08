import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/features/explore/controllers/explore_controller.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/widgets/news_list_tile.dart';
import 'package:odiya_news_app/core/widgets/no_objects_placeholder.dart';

class CategoriesTabView extends StatelessWidget {
  final ExploreScreenState state;

  const CategoriesTabView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final categories = state.categories;
    return TabBarView(
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
    void showMoreButton() => context.pushNamed(
      AppRoutes.category,
      pathParameters: {'categoryName': Uri.encodeComponent(category)},
    );
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
              _buildShowMoreButton(showMoreButton),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
    );
  }

  Widget _buildShowMoreButton(VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
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
