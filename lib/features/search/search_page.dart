import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/widgets/common_appbar.dart';
import 'package:odiya_news_app/features/explore/widgets/search_bar.dart';
import 'package:odiya_news_app/features/search/controllers/search_controller.dart';
import 'package:odiya_news_app/features/search/widgets/recent_searches.dart';
import 'package:odiya_news_app/features/search/widgets/search_results.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    final searchState = ref.read(searchControllerProvider);
    _searchController = TextEditingController(text: searchState.currentQuery);
    _searchFocusNode = FocusNode();
    _searchController.addListener(_handleTextChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  void _handleTextChange() {
    if (_searchController.text.isEmpty) {
      ref.read(searchControllerProvider.notifier).clearSearch();
    }
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_handleTextChange)
      ..dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchControllerProvider);
    final controller = ref.read(searchControllerProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppbar(title: AppStrings.search),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomSearchBar(
              controller: _searchController,
              focusNode: _searchFocusNode,
              hintText: AppStrings.searchHint,
              onSubmitted: (query) {
                if (query.trim().isNotEmpty) {
                  unawaited(
                    controller.searchArticles(query).catchError((_) {}),
                  );
                }
              },
              onClear: () {
                _searchController.clear();
                controller.clearSearch();
              },
              padding: const EdgeInsets.all(16.0),
            ),
          ),
          SliverToBoxAdapter(
            child: controller.shouldShowRecentSearches
                ? RecentSearches(
                    recentSearches: state.recentSearches,
                    onClearAll: controller.clearRecentSearches,
                    onTapSearch: (search) {
                      _searchController.text = search;
                      unawaited(
                        controller.searchArticles(search).catchError((_) {}),
                      );
                    },
                  )
                : SearchResults(
                    state: state,
                    onRefresh: () async {
                      final query = _searchController.text;
                      if (query.isNotEmpty) {
                        await controller
                            .searchArticles(query)
                            .catchError((_) {});
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
