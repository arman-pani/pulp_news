import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_colors.dart';
import 'package:odiya_news_app/core/constants/app_textstyles.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/features/bookmark/controllers/bookmark_controller.dart';
import 'package:odiya_news_app/core/utils/helper_methods.dart';

class NewsListTile extends ConsumerWidget {
  final NewsModel news;
  final VoidCallback? onBookmarkChanged;

  const NewsListTile({super.key, required this.news, this.onBookmarkChanged});

  Future<void> _toggleBookmark(WidgetRef ref) async {
    final bookmarkController = ref.read(bookmarkControllerProvider.notifier);
    await bookmarkController.toggleBookmark(news);
    onBookmarkChanged?.call();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedArticles =
        ref.watch(bookmarkControllerProvider).valueOrNull ??
        const <NewsModel>[];
    final isBookmarked = bookmarkedArticles.any(
      (article) => article.id == news.id,
    );

    return GestureDetector(
      onTap: () => context.push(AppRoutes.article, extra: news),
      child: Row(
        spacing: 12.0,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.shadow.withValues(alpha: 0.1),
                  blurRadius: 1.0,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                news.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                    ? child
                    : const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image,
                  size: 50,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    news.sourceName,
                    style: AppTextStyles.tag.copyWith(
                      color: AppColors.primaryOrange,
                    ),
                  ),
                  Text(
                    news.title,
                    style: AppTextStyles.subtitle,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    formatDate(news.publishedAt),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => _toggleBookmark(ref),
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked
                  ? AppColors.primaryOrange
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
