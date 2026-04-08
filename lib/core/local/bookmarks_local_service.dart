import 'package:odiya_news_app/core/local/hive_service.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

class BookmarksLocalService {
  BookmarksLocalService(this._hiveService);

  final HiveService _hiveService;

  Future<void> addBookmark(NewsModel article) async {
    await _hiveService.bookmarksBox.put(article.id, article);
  }

  Future<void> removeBookmark(String articleId) async {
    await _hiveService.bookmarksBox.delete(articleId);
  }

  bool isBookmarked(String articleId) {
    return _hiveService.bookmarksBox.containsKey(articleId);
  }

  List<NewsModel> getBookmarkedArticles() {
    return _hiveService.bookmarksBox.values.toList();
  }

  Future<void> clearAllBookmarks() async {
    await _hiveService.bookmarksBox.clear();
  }
}
