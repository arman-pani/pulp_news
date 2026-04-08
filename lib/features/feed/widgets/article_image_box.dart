import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_colors.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/features/bookmark/controllers/bookmark_controller.dart';
import 'package:odiya_news_app/core/utils/helper_methods.dart';
import 'package:odiya_news_app/core/widgets/custom_icon_button.dart';

class ArticleImageBox extends ConsumerWidget {
  const ArticleImageBox({
    super.key,
    required this.isBack,
    required this.article,
  });

  final NewsModel article;
  final bool isBack;

  Future<void> toggleBookmark(WidgetRef ref) async {
    await ref.read(bookmarkControllerProvider.notifier).toggleBookmark(article);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedArticles =
        ref.watch(bookmarkControllerProvider).valueOrNull ??
        const <NewsModel>[];
    final isBookmarked = bookmarkedArticles.any(
      (item) => item.id == article.id,
    );

    return SizedBox(
      height: 275, // Fixed height for the image section
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              article.imageUrl,
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

          // Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),

          // Action Buttons
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 15,
            child: Row(
              children: [
                if (isBack)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: CustomIconButton(
                      onTap: () => context.pop(),
                      icon: Icons.arrow_back_ios_rounded,
                    ),
                  ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: CustomIconButton(
                    onTap: () => toggleBookmark(ref),
                    icon: isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: isBookmarked
                        ? AppColors.primaryOrange
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                CustomIconButton(
                  onTap: () => shareArticle(article),
                  icon: Icons.share_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
