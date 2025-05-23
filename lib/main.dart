import 'package:recipe_app/util/app_export.dart';

import 'controllers/lang/lang_controller.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
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
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          translations: translation, // Your translation class
          locale: locale ?? Get.deviceLocale, // Gets the device locale
          fallbackLocale: const Locale('en', 'US'), // Fallback if locale not supported
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsUtil.white,
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