

import 'package:recipe_app/screen/auth/login_screen.dart';
import 'package:recipe_app/screen/auth/sign_up_screen.dart';
import 'package:recipe_app/screen/splash/splash_screen.dart';

import '../../util/app_export.dart';

class RouteHelper {
  static const splash = '/splash';
  static const login = '/login';
  static const signUp = '/signUp';

  static List<GetPage> pages = [
    GetPage(name: splash, page: ()=> SplashScreen()),
    GetPage(name: login, page: ()=> LoginScreen()),
    GetPage(name: signUp, page: ()=> SignUpScreen()),
  ];
}