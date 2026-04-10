import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_colors.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/features/bookmark/controllers/bookmark_controller.dart';

class NewsCard extends ConsumerWidget {
  const NewsCard({super.key, required this.newsModel, this.onBookmarkChanged});

  final NewsModel newsModel;
  final VoidCallback? onBookmarkChanged;

  Future<void> _toggleBookmark(WidgetRef ref) async {
    await ref
        .read(bookmarkControllerProvider.notifier)
        .toggleBookmark(newsModel);
    onBookmarkChanged?.call();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedArticles =
        ref.watch(bookmarkControllerProvider).valueOrNull ??
        const <NewsModel>[];
    final isBookmarked = bookmarkedArticles.any(
      (article) => article.id == newsModel.id,
    );

    return GestureDetector(
      onTap: () => context.push(AppRoutes.article, extra: newsModel),
      child: Card(
        elevation: 20,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 175,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      newsModel.imageUrl,
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
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () => _toggleBookmark(ref),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: isBookmarked
                            ? AppColors.primaryOrange
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                spacing: 8.0,
                children: [
                  Text(
                    newsModel.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8.0,
                    children: [
                      Text(
                        "${newsModel.relativeTime} | ${newsModel.sourceName}",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
