import 'dart:async';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:odiya_news_app/utils/app_router.dart';
import 'package:odiya_news_app/services/hive_service.dart';
import 'package:odiya_news_app/services/auth_service.dart';
import 'package:odiya_news_app/services/bookmark_service.dart';
import 'package:odiya_news_app/services/fcm_service.dart';
import 'package:odiya_news_app/services/settings_service.dart';
import 'package:odiya_news_app/constants/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();

  // Initialize only critical services that are needed immediately
  await Get.putAsync<HiveService>(() async => await HiveService().init());
  Get.put(SettingsService(), permanent: true);
  await Get.putAsync<BookmarkService>(
    () async => BookmarkService(),
    permanent: true,
  );

  await setupRouter();

  // Initialize non-critical services in background after app loads
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _initializeBackgroundServices();
  });

  runApp(const MyApp());
}

void _initializeBackgroundServices() {
  // Initialize services in background without blocking UI
  unawaited(MobileAds.instance.initialize());
  unawaited(
    Get.putAsync<AuthService>(() async => AuthService(), permanent: true),
  );
  unawaited(
    Get.putAsync<FCMService>(() async => FCMService(), permanent: true),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return GetX<SettingsService>(
      builder: (settingsService) {
        // Access the observable variable to ensure GetX tracks it
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
