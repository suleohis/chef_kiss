

import 'package:recipe_app/controllers/splash/splash_binding.dart';
import 'package:recipe_app/screen/auth/forgot_password_screen.dart';
import 'package:recipe_app/screen/auth/login_screen.dart';
import 'package:recipe_app/screen/auth/sign_up_screen.dart';
import 'package:recipe_app/screen/dashboard/dashboard_screen.dart';
import 'package:recipe_app/screen/recipe_detail/recipe_detail_screen.dart';
import 'package:recipe_app/screen/search_recipes/search_recipes_screen.dart';
import 'package:recipe_app/screen/splash/splash_screen.dart';

import '../../util/app_export.dart';

class RouteHelper {
  static const initial = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const signUp = '/signUp';
  static const forgotPassword = '/forgotPassword';
  static const searchRecipe = '/searchRecipe';
  static const recipeDetail = '/recipeDetail';

  static List<GetPage> pages = [
    GetPage(name: splash,
        binding: SplashBinding(),
        page: ()=> SplashScreen()),
    /// Auth
    GetPage(name: login, page: ()=> LoginScreen()),
    GetPage(name: signUp, page: ()=> SignUpScreen()),
    GetPage(name: forgotPassword, page: ()=> ForgotPasswordScreen()),

    ///Search
    GetPage(name: initial, page: ()=> DashboardScreen()),

    /// Search Recipe
    GetPage(name: searchRecipe, page: ()=> SearchRecipesScreen()),

    /// Recipe Detail
    GetPage(name: recipeDetail, page: ()=> RecipeDetailScreen()),
  ];
}