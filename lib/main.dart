import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_app/util/app_export.dart';

import 'controllers/lang/lang_controller.dart';
import 'data/services/notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Firebase Analytics
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  // Pass all error that not Flutter framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Notification
  Future.delayed(Duration(seconds: 3), () async {
    await NotificationService().init();

    // --- Schedule Daily Notifications for Breakfast, Lunch, and Dinner ---

    // Breakfast Reminder (e.g., 8:00 AM)
    await NotificationService().scheduleDailyNotification(
      100, // Unique ID for Breakfast notification
      '🍳 Breakfast Time!',
      'Good morning! Time for a delicious breakfast to start your day right!',
      DateTime(2025, 5, 2, 8, 0, 0), // 8:00 AM
      payload: 'daily_breakfast_reminder',
    );

    // Lunch Reminder (e.g., 1:00 PM)
    await NotificationService().scheduleDailyNotification(
      101, // Unique ID for Lunch notification
      '🍲 Lunch Break!',
      'It\'s lunchtime! What delicious meal will you prepare today?',
      DateTime(2025, 5, 2, 13, 0, 0), // 1:00 PM
      payload: 'daily_lunch_reminder',
    );


    // --- End of Notification Scheduling ---
  });

  // Translation
  final translation = Translation();
  await translation.load();
  var dat = await translation.getLang();
  Locale locale = Locale(dat.value);
  runApp(MyApp(translation: translation, locale: locale));
}

class MyApp extends StatelessWidget {
  final Translation? translation;
  final Locale? locale;
  const MyApp({super.key, this.translation, this.locale});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: size,
      minTextAdapt: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: ConstUtil.appName,
          translations: translation,
          locale: locale ?? Get.deviceLocale,
          fallbackLocale: const Locale(
            'en',
            'US',
          ),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
          ],
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsUtil.white,
            appBarTheme: AppBarTheme(backgroundColor: ColorsUtil.white),
            colorScheme: ColorScheme.fromSeed(seedColor: ColorsUtil.primary),
          ),
          getPages: RouteHelper.pages,
          initialRoute: RouteHelper.splash,
          home: child,
        );
      },
    );
  }
}
