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

   /// You can schedule your daily notification here
   await NotificationService().scheduleDailyNotification(
     0, // Unique ID for this notification
     'Meal Reminder!',
     'Time to plan your delicious meal for today!',
     DateTime(2025, 5, 2, 23, 5, 0), // 8:00 AM
     payload: 'daily_meal_reminder',
   );
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
          onInit: () async{
            /// Notification
            /// Initialize your notification service
            await NotificationService().init();

            /// You can schedule your daily notification here
            await NotificationService().scheduleDailyNotification(
              0, // Unique ID for this notification
              'Meal Reminder!',
              'Time to plan your delicious meal for today!',
              DateTime(2025, 5, 2, 23, 5, 0), // 8:00 AM
              payload: 'daily_meal_reminder',
            );
          },
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