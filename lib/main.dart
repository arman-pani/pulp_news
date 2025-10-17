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
import 'package:odiya_news_app/controllers/settings_controller.dart';
import 'package:odiya_news_app/home/home_controller.dart';
import 'package:odiya_news_app/constants/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Mobile Ads
  await MobileAds.instance.initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize GetXServices (kept in memory throughout app lifecycle)
  await Get.putAsync<HiveService>(() async => await HiveService().init());
  Get.put(AuthService(), permanent: true);
  await Get.putAsync<BookmarkService>(() async => BookmarkService(), permanent: true);
  await Get.putAsync<FCMService>(() async => FCMService(), permanent: true);
  Get.put(SettingsController(), permanent: true); // Initialize SettingsController after FCMService
  await Get.putAsync<HomeController>(() async => HomeController(), permanent: true); // Initialize HomeController


  // Initialize Firebase Auth and sign in anonymously
  await _initializeAuth();

  await setupRouter();

  // DioHandler.setup();

  runApp(const MyApp());
}

Future<void> _initializeAuth() async {
  try {
    // Sign in anonymously if no user is signed in
    await AuthService.to.signInAnonymously();
  } catch (e) {
    debugPrint('Error signing in anonymously: $e');
  }
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetX<SettingsController>(
      builder: (settingsController) {
        // Access the observable variable to ensure GetX tracks it
        final themeMode = settingsController.themeModeObs.value;

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
