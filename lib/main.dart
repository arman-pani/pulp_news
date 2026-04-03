import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:odiya_news_app/utils/app_router.dart';
import 'package:odiya_news_app/services/hive_service.dart';
import 'package:odiya_news_app/services/token_storage.dart';
import 'package:odiya_news_app/services/auth_service.dart';
import 'package:odiya_news_app/services/bookmark_service.dart';
import 'package:odiya_news_app/services/fcm_service.dart';
import 'package:odiya_news_app/services/settings_service.dart';
import 'package:odiya_news_app/constants/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables before anything else
  await dotenv.load(fileName: '.env');

  // Firebase is still required for FCM and Remote Config
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize critical services synchronously before the first frame
  await Get.putAsync<HiveService>(
    () async => await HiveService().init(),
    permanent: true,
  );

  // Load JWT tokens from OS keychain into memory cache before AuthService
  await Get.putAsync<TokenStorage>(
    () async => await TokenStorage().init(),
    permanent: true,
  );

  Get.put(SettingsService(), permanent: true);
  Get.put(BookmarkService(), permanent: true);

  // AuthService must be initialised before the UI renders so the access token
  // is ready for the first API call (home feed, bundled articles, etc.)
  await Get.putAsync<AuthService>(
    () async => await AuthService().init(),
    permanent: true,
  );
  await setupRouter();

  // Non-critical services can initialise in the background
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _initializeBackgroundServices();
  });

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

void _initializeBackgroundServices() {
  unawaited(MobileAds.instance.initialize());

  unawaited(
    Get.putAsync<FCMService>(() async {
      final service = FCMService();
      await service.initializeIfNeeded();
      return service;
    }, permanent: true),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsService>(
      builder: (settingsService) {
        final themeMode = settingsService.themeMode;

        return MaterialApp.router(
          title: 'Pulp News',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
