import 'package:hive_flutter/hive_flutter.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

class HiveService {
  static const String articlesBoxName = 'articles';
  static const String bookmarksBoxName = 'bookmarks';
  static const String recentSearchesBoxName = 'recent_searches';
  static const String settingsBoxName = 'settings';

  late Box<NewsModel> _articlesBox;
  late Box<NewsModel> _bookmarksBox;
  late Box<String> _recentSearchesBox;
  late Box<String> _settingsBox;

  Future<HiveService> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NewsModelAdapter());
    }

    _articlesBox = await Hive.openBox<NewsModel>(articlesBoxName);
    _bookmarksBox = await Hive.openBox<NewsModel>(bookmarksBoxName);
    _recentSearchesBox = await Hive.openBox<String>(recentSearchesBoxName);
    _settingsBox = await Hive.openBox<String>(settingsBoxName);

    return this;
  }

  Box<NewsModel> get articlesBox => _articlesBox;
  Box<NewsModel> get bookmarksBox => _bookmarksBox;
  Box<String> get recentSearchesBox => _recentSearchesBox;
  Box<String> get settingsBox => _settingsBox;

  Future<void> close() async {
    await _articlesBox.close();
    await _bookmarksBox.close();
    await _recentSearchesBox.close();
    await _settingsBox.close();
  }
}
