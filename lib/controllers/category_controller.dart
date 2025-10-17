import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/repository/articles_repository.dart';

class CategoryController extends GetxController {
  final ArticlesRepository _articlesRepository = ArticlesRepository();
  final String categoryName;
  CategoryController({required this.categoryName});
  
  // Category functionality
  List<NewsModel> categoryArticles = [];
  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;
  int currentOffset = 0;
  static const int articlesPerPage = 20;
  bool hasMoreArticles = true;
  bool isLoadingMore = false;
  
  // UI state management
  final ScrollController scrollController = ScrollController();
  bool isInitialized = false;
  
  // Debouncing mechanism to prevent duplicate calls
  bool _isLoadingMoreRequested = false;

  @override
  void onInit() {
    super.onInit();
    debugPrint('CategoryController onInit: $categoryName');
    loadCategoryArticles();
    _setupScrollListener();
  }

  @override
  void onClose() {
    debugPrint('CategoryController onClose: $categoryName');
    scrollController.dispose();
    super.onClose();
  }

  void _setupScrollListener() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Only trigger if we haven't already requested more articles
    if (!_isLoadingMoreRequested && 
        scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.8) {
      debugPrint('Scroll triggered - requesting more articles');
      _isLoadingMoreRequested = true;
      loadMoreArticles();
    }
  }

  Future<void> loadCategoryArticles() async {
    isLoading = true;
    hasError = false;
    errorMessage = null;
    currentOffset = 0;
    hasMoreArticles = true;
    isInitialized = true;
    _isLoadingMoreRequested = false; // Reset the flag
    update();

    try {
      debugPrint('Loading first page of articles for category: $categoryName');
      // Load first page of articles
      final articles = await _articlesRepository.getArticlesByCategory(
        categoryName,
        offset: currentOffset,
        limit: articlesPerPage,
      );
      
      categoryArticles = articles;
      hasMoreArticles = articles.length >= articlesPerPage;
      currentOffset = articles.length;
    } catch (e) {
      hasError = true;
      errorMessage = 'Failed to load articles. Please try again.';
      debugPrint('Error loading category articles: $e');
    }

    isLoading = false;
    update();
  }

  Future<void> loadMoreArticles() async {
    if (!hasMoreArticles || isLoadingMore || isLoading) {
      debugPrint('Cannot load more: hasMore=$hasMoreArticles, isLoadingMore=$isLoadingMore, isLoading=$isLoading');
      _isLoadingMoreRequested = false; // Reset flag if we can't load
      return;
    }

    isLoadingMore = true;
    update();

    try {
      debugPrint('Loading more articles for category: $categoryName, offset: $currentOffset');
      // Load next page of articles using current offset
      final newArticles = await _articlesRepository.getArticlesByCategory(
        categoryName,
        offset: currentOffset,
        limit: articlesPerPage,
      );
      
      if (newArticles.isNotEmpty) {
        categoryArticles.addAll(newArticles);
        currentOffset += newArticles.length;
        hasMoreArticles = newArticles.length >= articlesPerPage;
        debugPrint('Added ${newArticles.length} articles. Total: ${categoryArticles.length}, hasMore: $hasMoreArticles');
      } else {
        hasMoreArticles = false;
        debugPrint('No more articles available');
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Failed to load more articles. Please try again.';
      debugPrint('Error loading more articles: $e');
    }

    isLoadingMore = false;
    _isLoadingMoreRequested = false; // Reset the flag after completion
    update();
  }

  Future<void> refreshArticles() async {
    // Clear existing articles and reload
    categoryArticles.clear();
    _isLoadingMoreRequested = false; // Reset the flag
    await loadCategoryArticles();
  }

  // UI helper methods
  bool get shouldShowLoadingIndicator => isLoadingMore && categoryArticles.isNotEmpty;
  
  int get totalItemCount => categoryArticles.length + (shouldShowLoadingIndicator ? 1 : 0);
  
  bool get isEmpty => categoryArticles.isEmpty && !isLoading && !hasError;
  
  bool get hasData => categoryArticles.isNotEmpty;
}