import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/constants/app_colors.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/services/bookmark_service.dart';
import 'package:odiya_news_app/utils/app_router.dart';

class NewsCard extends StatelessWidget {
  final NewsModel newsModel;
  final VoidCallback? onBookmarkChanged;

  const NewsCard({super.key, required this.newsModel, this.onBookmarkChanged});

  bool get isBookmarked {
    final bookmarkService = Get.find<BookmarkService>();
    return bookmarkService.isBookmarked(newsModel.id);
  }

  void _toggleBookmark() async {
    final bookmarkService = Get.find<BookmarkService>();
    await bookmarkService.toggleBookmark(newsModel);
    onBookmarkChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bookmarkService = BookmarkService.instance;
      final isBookmarked = bookmarkService.isBookmarked(newsModel.id);
      
      return GestureDetector(
          onTap: () =>
              context.pushNamed(AppRoutes.articleDetail, extra: newsModel),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              spacing: 12.0,
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
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.image,
                            size: 50,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          newsModel.category,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: _toggleBookmark,
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 8.0,
                  children: [
                    Text(
                      newsModel.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          newsModel.relativeTime,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        Text(
                          newsModel.sourceName,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),

                    Text(
                      newsModel.content,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
