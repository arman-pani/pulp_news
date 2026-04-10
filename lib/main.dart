import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:odiya_news_app/core/ads/ad_unit_ids.dart';
import 'package:odiya_news_app/core/local/settings_local_service.dart';
import 'package:odiya_news_app/core/local/hive_service.dart';
import 'package:odiya_news_app/core/local/token_storage.dart';
import 'package:odiya_news_app/core/constants/app_theme.dart';
import 'package:odiya_news_app/core/providers/app_container.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/routing/app_router.dart';
import 'package:odiya_news_app/core/services/app_snackbar_service.dart';
import 'package:odiya_news_app/core/utils/helper_methods.dart';
import 'package:odiya_news_app/features/settings/controllers/settings_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables before anything else
  await dotenv.load(fileName: '.env');

  // Firebase is still required for FCM and Remote Config
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final hiveBootstrap = await HiveService().init();
  final settingsLocalService = SettingsLocalService(hiveBootstrap);
  final tokenStorage = await TokenStorage().init();
  final onboardingCompleted = settingsLocalService.getOnboardingCompleted();
  final appRouter = AppRouterHost(completedOnboarding: onboardingCompleted);
  final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final appSnackbarService = AppSnackbarService(rootScaffoldMessengerKey);

  appContainer = ProviderContainer(
    overrides: [
      hiveBootstrapProvider.overrideWith((ref) => hiveBootstrap),
      tokenStorageProvider.overrideWith((ref) => tokenStorage),
      appRouterProvider.overrideWith((ref) => appRouter),
      appSnackbarServiceProvider.overrideWith((ref) => appSnackbarService),
    ],
  );

  await appContainer.read(authServiceProvider).init();
  final initializationStatus = await MobileAds.instance.initialize();
  debugPrint(
    '[Ads] Mobile Ads initialized.'
    ' adapters=${initializationStatus.adapterStatuses.length}',
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    UncontrolledProviderScope(container: appContainer, child: const MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    AdUnitIds.logResolvedConfig();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(ref.read(fcmServiceProvider).initializeIfNeeded());
      final context = ref.read(appRouterProvider).currentContext;
      if (context != null && context.mounted) {
        unawaited(checkAppVersion(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsServiceProvider);

    return Builder(
      builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarDividerColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: MaterialApp.router(
            title: 'Pulp News',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsState.themeMode,
            routerConfig: ref.watch(appRouterProvider).router,
            scaffoldMessengerKey: ref
                .read(appSnackbarServiceProvider)
                .messengerKey,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
