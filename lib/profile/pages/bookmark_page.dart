import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/services/bookmark_service.dart';
import 'package:odiya_news_app/widgets/news_list_tile.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bookmarkService = BookmarkService.instance;
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          title: Text(
            AppStrings.bookmarks,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            if (bookmarkService.hasData)
              IconButton(
                icon: const Icon(Icons.clear_all),
                onPressed: () {
                  _showClearAllDialog(context, bookmarkService);
                },
              ),
          ],
        ),
        body: _buildBody(context, bookmarkService),
      );
    });
  }

  Widget _buildBody(BuildContext context, BookmarkService bookmarkService) {
    if (bookmarkService.isLoading &&
        bookmarkService.bookmarkedArticles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (bookmarkService.hasError &&
        bookmarkService.bookmarkedArticles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.errorOccurred,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              bookmarkService.errorMessage ?? AppStrings.tryAgain,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => bookmarkService.loadBookmarkedArticles(),
              child: Text(AppStrings.tryAgain),
            ),
          ],
        ),
      );
    }

    if (bookmarkService.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noBookmarks,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.bookmarksDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: bookmarkService.bookmarkedArticles.length,
      itemBuilder: (context, index) {
        final article = bookmarkService.bookmarkedArticles[index];
        return NewsListTile(news: article);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
    );
  }

  void _showClearAllDialog(
    BuildContext context,
    BookmarkService bookmarkService,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.clearAllBookmarks),
        content: Text(AppStrings.clearAllBookmarksConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              await bookmarkService.clearAllBookmarks();
              if (context.mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppStrings.allBookmarksCleared)),
                );
              }
            },
            child: Text(AppStrings.clearAllBookmarks),
          ),
        ],
      ),
    );
  }
}
