

import 'package:recipe_app/controllers/splash/splash_binding.dart';
import 'package:recipe_app/screen/auth/login_screen.dart';
import 'package:recipe_app/screen/auth/sign_up_screen.dart';
import 'package:recipe_app/screen/dashboard/dashboard_screen.dart';
import 'package:recipe_app/screen/splash/splash_screen.dart';

import '../../util/app_export.dart';

class RouteHelper {
  static const splash = '/splash';
  static const login = '/login';
  static const signUp = '/signUp';
  static const initial = '/';

  static List<GetPage> pages = [
    GetPage(name: splash,
        binding: SplashBinding(),
        page: ()=> SplashScreen()),
    GetPage(name: login, page: ()=> LoginScreen()),
    GetPage(name: signUp, page: ()=> SignUpScreen()),
    GetPage(name: initial, page: ()=> DashboardScreen()),
  ];
}