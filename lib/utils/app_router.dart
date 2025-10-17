import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/onboarding/country_page.dart';
import 'package:odiya_news_app/profile/pages/bookmark_page.dart';
import 'package:odiya_news_app/home/home_page.dart';
import 'package:odiya_news_app/index.dart';
import 'package:odiya_news_app/onboarding/onboarding_page.dart';
import 'package:odiya_news_app/profile/pages/profile_page.dart';
import 'package:odiya_news_app/pages/explore_page.dart';
import 'package:odiya_news_app/pages/category_page.dart';
import 'package:odiya_news_app/home/article_detail_page.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/search/search_page.dart';
import 'package:odiya_news_app/pages/web_view_page.dart';
import 'package:odiya_news_app/profile/pages/settings_page.dart';
import 'package:odiya_news_app/utils/app_handler.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();
final _exploreNavigatorKey = GlobalKey<NavigatorState>();

late final GoRouter goRouter;

Future<void> setupRouter() async {
  final completed = await hasCompletedOnboarding();

  goRouter = GoRouter(
    initialLocation: '/india-map',
    // initialLocation: completed ? '/explore' : '/onboarding',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoutes.onboarding,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: OnboardingPage()),
      ),

      GoRoute(
        path: '/india-map',
        name: AppRoutes.indiaMap,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: IndiaMapPage()),
      ),
      GoRoute(
        path: '/article-detail',
        name: AppRoutes.articleDetail,
        pageBuilder: (context, state) {
          final article = state.extra as NewsModel;
          return NoTransitionPage(child: ArticleDetailPage(article: article));
        },
      ),
      GoRoute(
        path: '/webview',
        name: AppRoutes.webView,
        pageBuilder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';
          final title = state.uri.queryParameters['title'] ?? 'Web View';
          return NoTransitionPage(
            child: WebViewPage(url: url, title: title),
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return IndexPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                name: AppRoutes.home,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: ExplorePage()),

                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: '/search',
                    name: AppRoutes.search,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: SearchPage()),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: '/category/:categoryName',
                    name: AppRoutes.category,
                    pageBuilder: (context, state) {
                      final categoryName =
                          state.pathParameters['categoryName']!;
                      return NoTransitionPage(
                        child: CategoryPage(categoryName: categoryName),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _exploreNavigatorKey,
            routes: [
              GoRoute(
                path: '/explore',
                name: AppRoutes.explore,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomePage()),
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: AppRoutes.profile,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePage()),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: '/bookmark',
                    name: AppRoutes.bookmark,
                    pageBuilder: (context, state) =>
                        NoTransitionPage(child: BookmarkPage()),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: '/settings',
                    name: AppRoutes.settings,
                    pageBuilder: (context, state) =>
                        NoTransitionPage(child: SettingsPage()),
                  ),

                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class AppRoutes {
  static const String onboarding = 'onboarding';
  static const String home = 'home';
  static const String indiaMap = 'indiaMap';
  static const String bookmark = 'bookmark';
  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String explore = 'explore';
  static const String search = 'search';
  static const String category = 'category';
  static const String articleDetail = 'articleDetail';
  static const String webView = 'webView';
}
