import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/repository/articles_repository.dart';
import 'package:odiya_news_app/services/hive_service.dart';

class NewsSearchController extends GetxController {
  final hiveService = Get.find<HiveService>();
  final ArticlesRepository _articlesRepository = ArticlesRepository();

  // Search functionality
  List<NewsModel> searchResults = [];
  List<String> recentSearches = [];
  bool isSearching = false;
  bool hasSearchError = false;
  String? searchErrorMessage;
  String currentQuery = '';

  // UI state management
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
    _setupSearchController();

    // Focus the search field when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusSearchField();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  void _setupSearchController() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        clearSearch();
      }
    });
  }

  void focusSearchField() {
    searchFocusNode.requestFocus();
  }

  void loadRecentSearches() {
    recentSearches = hiveService.getRecentSearches();
    update();
  }

  Future<void> searchArticles(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      currentQuery = '';
      isSearching = false;
      update();
      return;
    }

    currentQuery = query;
    searchController.text = query; // Sync with text field
    isSearching = true;
    hasSearchError = false;
    searchErrorMessage = null;
    update();

    try {
      searchResults = await _articlesRepository.searchArticles(query);

      // Save to recent searches
      await hiveService.addRecentSearch(query);
      loadRecentSearches();
    } catch (e) {
      hasSearchError = true;
      searchErrorMessage = 'Failed to search articles. Please try again.';
      debugPrint('Error searching articles: $e');
    }

    isSearching = false;
    update();
  }

  void clearSearch() {
    searchResults.clear();
    currentQuery = '';
    searchController.clear();
    isSearching = false;
    hasSearchError = false;
    searchErrorMessage = null;
    update();
  }

  void clearRecentSearches() async {
    await hiveService.clearRecentSearches();
    loadRecentSearches();
  }

  // UI helper methods
  bool get hasSearchResults => searchResults.isNotEmpty;

  bool get hasRecentSearches => recentSearches.isNotEmpty;

  bool get shouldShowRecentSearches => currentQuery.isEmpty && !isSearching;

  bool get shouldShowSearchResults => currentQuery.isNotEmpty && !isSearching;

  bool get shouldShowLoading => isSearching;

  bool get shouldShowError => hasSearchError;

  bool get shouldShowEmpty =>
      !isSearching &&
      !hasSearchError &&
      currentQuery.isNotEmpty &&
      searchResults.isEmpty;
}
