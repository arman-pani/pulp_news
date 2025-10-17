
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/constants/app_colors.dart';
import 'package:odiya_news_app/home/widgets/custom_icon_button.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/services/bookmark_service.dart';
import 'package:odiya_news_app/utils/helper_methods.dart';

class ArticleImageBox extends StatelessWidget {
  ArticleImageBox({super.key, required this.isBack, required this.article});

  final NewsModel article;
  final bool isBack;
  final BookmarkService _bookmarkService = Get.find<BookmarkService>();

  void toggleBookmark() async {
    await _bookmarkService.toggleBookmark(article);
  }

  @override
  Widget build(BuildContext context) {
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
                    Colors.black.withOpacity(0.4), // Fixed this line
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
                // Use Obx to make bookmark button reactive
                Obx(() {
                  final isBookmarked = _bookmarkService.isBookmarked(article.id);
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CustomIconButton(
                      onTap: toggleBookmark,
                      icon: isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: isBookmarked
                          ? AppColors.primaryOrange
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  );
                }),
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