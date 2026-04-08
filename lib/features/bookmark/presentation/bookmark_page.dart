import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/utils/dialogs.dart';
import 'package:odiya_news_app/core/widgets/common_appbar.dart';
import 'package:odiya_news_app/core/widgets/no_objects_placeholder.dart';
import 'package:odiya_news_app/features/bookmark/controllers/bookmark_controller.dart';
import 'package:odiya_news_app/core/widgets/news_list_tile.dart';

class BookmarkPage extends ConsumerWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksState = ref.watch(bookmarkControllerProvider);
    final bookmarkController = ref.read(bookmarkControllerProvider.notifier);
    final bookmarks = bookmarksState.valueOrNull ?? const <NewsModel>[];

    void handleClear() => showAlertDialog(
      title: AppStrings.clearAllBookmarks,
      content: AppStrings.clearAllBookmarksConfirm,
      context: context,
      onConfirm: () async {
        await bookmarkController.clearAllBookmarks();
        if (context.mounted) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppStrings.allBookmarksCleared)),
          );
        }
      },
    );

    return Scaffold(
      appBar: CommonAppbar(
        title: AppStrings.bookmarks,
        actions: [
          if (bookmarks.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: handleClear,
            ),
        ],
      ),
      body: bookmarks.isEmpty
          ? NoObjectsPlaceholder(
              title: AppStrings.noBookmarks,
              icon: Icons.bookmark_border,
              subTitle: AppStrings.bookmarksDescription,
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final article = bookmarks[index];
                return NewsListTile(news: article);
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0),
            ),
    );
  }
}
