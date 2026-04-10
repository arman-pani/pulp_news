import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/models/bundled_articles_response.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

class ArticlesRepository {
  ArticlesRepository(this._dio);

  final Dio _dio;

  /// Fetch articles not yet seen by the authenticated user.
  /// The server marks them as seen on response.
  Future<List<NewsModel>> getUnseenArticles({int limit = 20}) async {
    try {
      final response = await _dio.get(
        '/articles/unseen',
        queryParameters: {'limit': limit},
      );

      final articlesData =
          (response.data as Map<String, dynamic>)['articles'] as List;
      return articlesData
          .map((e) => NewsModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      debugPrint('[ArticlesRepository] getUnseenArticles error: $e');
      rethrow;
    }
  }

  /// Full-text fuzzy search across article titles and content.
  Future<List<NewsModel>> searchArticles(
    String query, {
    int limit = 20,
    int offset = 0,
    String? category,
  }) async {
    try {
      final response = await _dio.get(
        '/articles/search',
        queryParameters: {
          'q': query,
          'limit': limit,
          'offset': offset,
          if (category != null) 'category': category,
        },
      );

      final articlesData =
          (response.data as Map<String, dynamic>)['articles'] as List;
      return articlesData
          .map((e) => NewsModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      debugPrint('[ArticlesRepository] searchArticles error: $e');
      rethrow;
    }
  }

  /// Fetch articles by category with pagination support.
  Future<List<NewsModel>> getArticlesByCategory(
    String category, {
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/articles/by-category',
        queryParameters: {
          'category': category,
          'limit': limit,
          'offset': offset,
        },
      );

      final articlesData =
          (response.data as Map<String, dynamic>)['articles'] as List;
      return articlesData
          .map((e) => NewsModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      debugPrint('[ArticlesRepository] getArticlesByCategory error: $e');
      rethrow;
    }
  }

  /// Get the latest articles grouped by every permanent category.
  Future<BundledArticlesResponse> getBundledArticles({
    int limitPerCategory = 5,
  }) async {
    final response = await _dio.get(
      '/articles/bundled',
      queryParameters: {'limit_per_category': limitPerCategory},
    );
    final bundledResponse = BundledArticlesResponse.fromJson(
      Map<String, dynamic>.from(response.data),
    );
    debugPrint("bundledResponse: $bundledResponse");
    return bundledResponse;
  }
}
