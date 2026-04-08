import 'package:odiya_news_app/core/local/hive_service.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

class ArticlesLocalService {
  ArticlesLocalService(this._hiveService);

  static const _maxArticlesLimit = 50;
  final HiveService _hiveService;

  Future<void> saveArticles(List<NewsModel> articles) async {
    for (final article in articles) {
      final existingArticle = _hiveService.articlesBox.get(article.id);
      if (existingArticle == null) {
        await _hiveService.articlesBox.put(article.id, article);
      }
    }

    await _maintainArticleLimit();
  }

  Future<void> _maintainArticleLimit() async {
    final allArticles = _hiveService.articlesBox.values.toList();
    if (allArticles.length <= _maxArticlesLimit) {
      return;
    }

    allArticles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    final articlesToRemove = allArticles.skip(_maxArticlesLimit).toList();

    for (final article in articlesToRemove) {
      await _hiveService.articlesBox.delete(article.id);
    }
  }

  List<NewsModel> getArticles() {
    return _hiveService.articlesBox.values.toList();
  }

  List<NewsModel> getUnseenArticles() {
    final allArticles = _hiveService.articlesBox.values.toList();
    return allArticles.where((article) => !article.isSeen).toList()
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  NewsModel? getArticle(String id) {
    return _hiveService.articlesBox.get(id);
  }

  Future<void> markArticleAsSeen(String articleId) async {
    final article = _hiveService.articlesBox.get(articleId);
    if (article == null) return;

    final updatedArticle = article.copyWith(isSeen: true);
    await _hiveService.articlesBox.put(articleId, updatedArticle);
  }

  Future<void> clearArticles() async {
    await _hiveService.articlesBox.clear();
  }

  bool hasUnseenArticles() {
    return _hiveService.articlesBox.values.any((article) => !article.isSeen);
  }

  int getUnseenArticlesCount() {
    return _hiveService.articlesBox.values
        .where((article) => !article.isSeen)
        .length;
  }
}
