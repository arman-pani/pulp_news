import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';

part 'bookmark_controller.g.dart';

@Riverpod(keepAlive: true)
class BookmarkController extends _$BookmarkController {
  @override
  FutureOr<List<NewsModel>> build() {
    return ref.read(bookmarksLocalServiceProvider).getBookmarkedArticles();
  }

  Future<void> loadBookmarkedArticles() async {
    await _setBookmarksState(
      () async =>
          ref.read(bookmarksLocalServiceProvider).getBookmarkedArticles(),
      showLoading: true,
    );
  }

  Future<void> addBookmark(NewsModel article) async {
    await _mutateBookmarks(() async {
      await ref.read(bookmarksLocalServiceProvider).addBookmark(article);
    });
  }

  Future<void> removeBookmark(String articleId) async {
    await _mutateBookmarks(() async {
      await ref.read(bookmarksLocalServiceProvider).removeBookmark(articleId);
    });
  }

  Future<void> toggleBookmark(NewsModel article) async {
    if (isBookmarked(article.id)) {
      await removeBookmark(article.id);
      return;
    }

    await addBookmark(article);
  }

  bool isBookmarked(String articleId) {
    final bookmarks = state.valueOrNull ?? const <NewsModel>[];
    return bookmarks.any((article) => article.id == articleId);
  }

  Future<void> clearAllBookmarks() async {
    await _mutateBookmarks(() async {
      await ref.read(bookmarksLocalServiceProvider).clearAllBookmarks();
    });
  }

  Future<void> _mutateBookmarks(Future<void> Function() mutation) async {
    await _setBookmarksState(() async {
      await mutation();
      return ref.read(bookmarksLocalServiceProvider).getBookmarkedArticles();
    });
  }

  Future<void> _setBookmarksState(
    Future<List<NewsModel>> Function() action, {
    bool showLoading = false,
  }) async {
    final previousState = state;

    if (showLoading) {
      state = const AsyncLoading<List<NewsModel>>().copyWithPrevious(
        previousState,
      );
    }

    try {
      final bookmarks = await action();
      state = AsyncData(bookmarks);
    } catch (error, stackTrace) {
      debugPrint('BookmarkController error: $error');
      state = AsyncError<List<NewsModel>>(
        error,
        stackTrace,
      ).copyWithPrevious(previousState);
    }
  }
}
