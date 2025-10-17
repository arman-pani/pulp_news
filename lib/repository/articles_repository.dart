import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/services/firebase_functions_service.dart';

class ArticlesRepository {
  final FirebaseFunctions _functions;

  ArticlesRepository()
      : _functions = FirebaseFunctionsService.instance.functions {
    // _functions.useFunctionsEmulator("192.168.29.107", 5001);
    
  }

  /// Fetch unseen articles
  Future<List<NewsModel>> getUnseenArticles({int limit = 20}) async {
    try {
      final callable = _functions.httpsCallable('get_unseen_articles_endpoint');
      final result = await callable.call({
        'limit': limit,
      });

      // Handle the response structure: { articles: [...], total: ..., limit: ..., success: ... }
      final responseData = result.data;
      final articlesData = responseData['articles'];

      return (articlesData as List)
        .map((e) => NewsModel.fromMap(e))
        .toList();
    } catch (e) {
      debugPrint('Error fetching unseen articles: $e');
      rethrow; // Rethrow the error so the controller can handle it
    }
  }

  /// Search articles by query string
  Future<List<NewsModel>> searchArticles(String query) async {
    try {
      final callable = _functions.httpsCallable('search_articles_endpoint');
      final result = await callable.call({
        'q': query,
      });

      // Handle the response structure: { articles: [...], total: ..., limit: ..., success: ... }
      final responseData = result.data;
      final articlesData = responseData['articles'];

      return (articlesData as List)
        .map((e) => NewsModel.fromMap(e))
        .toList();
    } catch (e) {
      debugPrint('Error searching articles: $e');
      rethrow;
    }
  }

  /// Fetch articles by category with pagination support
  Future<List<NewsModel>> getArticlesByCategory(
    String category, {
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final callable = _functions.httpsCallable('get_articles_by_category_endpoint');
      debugPrint('Getting articles by category: $category');
      final result = await callable.call({
        'category': category,
        'offset': offset,
        'limit': limit,
      });

      // Handle the response structure: { articles: [...], total: ..., limit: ..., success: ... }
      final responseData = result.data;
      final articlesData = responseData['articles'];

      return (articlesData as List)
        .map((e) => NewsModel.fromMap(e))
        .toList();
    } catch (e) {
      debugPrint('Error fetching articles by category: $e');
      rethrow;
    }
  }

  /// Get bundled articles from all categories
  Future<Map<String, dynamic>> getBundledArticles({
    int limitPerCategory = 5,
  }) async {
    try {
      final callable = _functions.httpsCallable('get_bundled_articles_endpoint');
      final result = await callable.call({
        'limit_per_category': limitPerCategory,
      });
      return result.data;
    } catch (e) {
      debugPrint('Error fetching bundled articles: $e');
      rethrow;
    }
  }
}