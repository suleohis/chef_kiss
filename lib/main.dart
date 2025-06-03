import 'package:recipe_app/util/app_export.dart';

import 'controllers/lang/lang_controller.dart';
import 'data/services/notification_service.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

 Future.delayed(Duration(seconds: 3), () async {
   /// Notification
   /// Initialize your notification service
   await NotificationService().init();

   // --- Schedule Daily Notifications for Breakfast, Lunch, and Dinner ---

   // Breakfast Reminder (e.g., 8:00 AM)
   await NotificationService().scheduleDailyNotification(
     100, // Unique ID for Breakfast notification
     '🍳 Breakfast Time!',
     'Good morning! Time for a delicious breakfast to start your day right!',
    DateTime(2025, 5, 2, 8, 0, 0),// 8:00 AM
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

   // Dinner Reminder (e.g., 7:00 PM)
   await NotificationService().scheduleDailyNotification(
     102, // Unique ID for Dinner notification
     '🍽️ Dinner Time!',
     'Evening! Time to cook up a fantastic dinner. Find your next favorite recipe!',
     DateTime(2025, 5, 2, 19, 0, 0), // 7:00 PM
     payload: 'daily_dinner_reminder',
   );

   // --- End of Notification Scheduling ---
 });

  final translation = Translation();
  await translation.load();
  var dat = await translation.getLang();
  Locale locale = Locale(dat.value);
  runApp( MyApp(translation: translation, locale: locale,));
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
      builder: (_, child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: ConstUtil.appName,
          translations: translation, // Your translation class
          locale: locale ?? Get.deviceLocale, // Gets the device locale
          fallbackLocale: const Locale('en', 'US'), // Fallback if locale not supported
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsUtil.white,
            appBarTheme: AppBarTheme(backgroundColor: ColorsUtil.white),
            colorScheme: ColorScheme.fromSeed(seedColor: ColorsUtil.primary),
          ),
          getPages: RouteHelper.pages,
          initialRoute: RouteHelper.splash,
          home: child,
        );
      }
    );
  }
}