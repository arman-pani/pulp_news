import 'package:odiya_news_app/core/local/hive_service.dart';

class RecentSearchesLocalService {
  RecentSearchesLocalService(this._hiveService);

  final HiveService _hiveService;

  Future<void> addRecentSearch(String query) async {
    if (query.trim().isEmpty) return;

    final searches = _hiveService.recentSearchesBox.values.toList();
    searches.remove(query);
    searches.insert(0, query);

    final trimmed = searches.take(10).toList();
    await _hiveService.recentSearchesBox.clear();
    await _hiveService.recentSearchesBox.addAll(trimmed);
  }

  List<String> getRecentSearches() {
    return _hiveService.recentSearchesBox.values.toList();
  }

  Future<void> clearRecentSearches() async {
    await _hiveService.recentSearchesBox.clear();
  }
}
