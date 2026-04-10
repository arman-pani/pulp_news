import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/core/widgets/bottom_nav_bar.dart';
import 'package:odiya_news_app/features/home/screens/article_detail_page.dart';
import 'package:odiya_news_app/features/home/screens/category_page.dart';
import 'package:odiya_news_app/features/home/screens/home_page.dart';
import 'package:odiya_news_app/features/feed/screens/feed_page.dart';
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
      appBar: navigationShell.currentIndex == 2
          ? AppBar(
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              title: Text(
                AppStrings.profile,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : null,
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
      feedNavigatorKey = GlobalKey<NavigatorState>() {
    router = GoRouter(
      initialLocation: completedOnboarding
          ? AppRoutes.feed
          : AppRoutes.onboarding,
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
          path: AppRoutes.onboarding,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: OnboardingPage()),
        ),
        GoRoute(
          path: AppRoutes.language,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LanguagePage()),
        ),
        GoRoute(
          path: AppRoutes.article,
          pageBuilder: (context, state) {
            final article = state.extra as NewsModel;
            return NoTransitionPage(child: ArticleDetailPage(article: article));
          },
        ),
        GoRoute(
          path: AppRoutes.bookmark,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: BookmarkPage()),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SettingsPage()),
        ),
        GoRoute(
          path: AppRoutes.webView,
          pageBuilder: (context, state) {
            final url = state.extra as String;
            return NoTransitionPage(
              child: WebViewPage(url: url, title: 'Source Article'),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.search,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SearchPage()),
        ),
        GoRoute(
          path: AppRoutes.category,
          pageBuilder: (context, state) {
            final categoryName = state.extra as String;
            return NoTransitionPage(
              child: CategoryPage(categoryName: categoryName),
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
                  path: AppRoutes.home,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: HomePage()),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: feedNavigatorKey,
              routes: [
                GoRoute(
                  path: AppRoutes.feed,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: FeedPage()),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: profileNavigatorKey,
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: ProfilePage()),
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
  final GlobalKey<NavigatorState> feedNavigatorKey;
  late final GoRouter router;

  BuildContext? get currentContext => rootNavigatorKey.currentContext;
}
