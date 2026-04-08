import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/core/widgets/bottom_nav_bar.dart';
import 'package:odiya_news_app/features/explore/screens/article_detail_page.dart';
import 'package:odiya_news_app/features/explore/screens/category_page.dart';
import 'package:odiya_news_app/features/explore/screens/explore_page.dart';
import 'package:odiya_news_app/features/feed/screens/home_page.dart';
import 'package:odiya_news_app/features/onboarding/screens/language_page.dart';
import 'package:odiya_news_app/features/onboarding/screens/onboarding_page.dart';
import 'package:odiya_news_app/features/bookmark/presentation/bookmark_page.dart';
import 'package:odiya_news_app/features/settings/pages/profile_page.dart';
import 'package:odiya_news_app/core/models/news_model.dart';
import 'package:odiya_news_app/features/search/search_page.dart';
import 'package:odiya_news_app/features/webview/presentation/web_view_page.dart';
import 'package:odiya_news_app/features/settings/pages/settings_page.dart';

class IndexPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const IndexPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavBar(navigationShell: navigationShell),
    );
  }
}

class AppRouterHost {
  AppRouterHost({required bool completedOnboarding})
    : rootNavigatorKey = GlobalKey<NavigatorState>(),
      homeNavigatorKey = GlobalKey<NavigatorState>(),
      profileNavigatorKey = GlobalKey<NavigatorState>(),
      exploreNavigatorKey = GlobalKey<NavigatorState>() {
    router = GoRouter(
      initialLocation: completedOnboarding ? '/explore' : '/onboarding',
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/onboarding',
          name: AppRoutes.onboarding,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: OnboardingPage()),
        ),
        GoRoute(
          path: '/language',
          name: AppRoutes.language,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LanguagePage()),
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
              navigatorKey: homeNavigatorKey,
              routes: [
                GoRoute(
                  path: '/explore',
                  name: AppRoutes.explore,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: ExplorePage()),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: '/search',
                      name: AppRoutes.search,
                      pageBuilder: (context, state) =>
                          const NoTransitionPage(child: SearchPage()),
                    ),
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
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
              navigatorKey: exploreNavigatorKey,
              routes: [
                GoRoute(
                  path: '/home',
                  name: AppRoutes.home,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: HomePage()),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: profileNavigatorKey,
              routes: [
                GoRoute(
                  path: '/profile',
                  name: AppRoutes.profile,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: ProfilePage()),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: '/bookmark',
                      name: AppRoutes.bookmark,
                      pageBuilder: (context, state) =>
                          const NoTransitionPage(child: BookmarkPage()),
                    ),
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: '/settings',
                      name: AppRoutes.settings,
                      pageBuilder: (context, state) =>
                          const NoTransitionPage(child: SettingsPage()),
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

  final GlobalKey<NavigatorState> rootNavigatorKey;
  final GlobalKey<NavigatorState> homeNavigatorKey;
  final GlobalKey<NavigatorState> profileNavigatorKey;
  final GlobalKey<NavigatorState> exploreNavigatorKey;
  late final GoRouter router;

  BuildContext? get currentContext => rootNavigatorKey.currentContext;
}
