import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/repository/articles_repository.dart';

class ExploreController extends GetxController {
  final ArticlesRepository _articlesRepository = ArticlesRepository();

  // Category functionality
  List<String> categories = [];
  List<NewsModel> trendingNews = [];
  Map<String, List<NewsModel>> categoryArticles = {};
  Map<String, dynamic> bundledArticles = {};

  // Common loading and error states
  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  // UI state management
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadBundledArticles();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadBundledArticles({int limitPerCategory = 5}) async {
    isLoading = true;
    hasError = false;
    errorMessage = null;
    update();

    try {
      final response = await _articlesRepository.getBundledArticles(
        limitPerCategory: limitPerCategory,
      );
      bundledArticles = response;

      // Parse articles for each category and extract category names
      if (response['categories'] != null) {
        debugPrint(
          'Categories data: ${response['categories'].keys.toList().map((e) => e.runtimeType).toList()}',
        );
        final categoriesData = response['categories'];
        // Extract category names from the API response
        categories = categoriesData.keys.cast<String>().toList();
        debugPrint('Categories: $categories');

        // Clear previous trending news
        trendingNews.clear();

        for (final categoryName in categories) {
          final categoryData = categoriesData[categoryName];
          if (categoryData['articles'] != null) {
            // Safely convert dynamic list to List<Map<String, dynamic>>
            final articlesList = (categoryData['articles'] as List)
                .map((e) => Map<String, dynamic>.from(e as Map))
                .toList();

            final articles = articlesList
                .map((e) => NewsModel.fromMap(e))
                .toList();
            categoryArticles[categoryName] = articles;

            // Add 3rd index article to trending news if it exists
            if (articles.length > 2) {
              trendingNews.add(articles[2]);
            }
          }
        }
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Failed to load articles. Please try again.';
      debugPrint('Error loading bundled articles: $e');
    }

    isLoading = false;
    update();
  }

  List<NewsModel> getCategoryArticles(String category) {
    return categoryArticles[category] ?? [];
  }

  // UI helper methods
  bool get isDataLoaded => bundledArticles.isNotEmpty;

  bool get hasData => categoryArticles.isNotEmpty;

  bool get isEmpty => categoryArticles.isEmpty && !isLoading && !hasError;
}
