import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:recipe_app/controllers/home/home_controller.dart';
import 'package:recipe_app/screen/categories/categories_screen.dart';
import 'package:recipe_app/screen/recipe_ai/recipe_ai_screen.dart';
import 'package:recipe_app/util/controller_export.dart';

import '../../screen/bookmark/bookmark_screen.dart';
import '../../screen/home/home_screen.dart';

class DashboardController extends GetxController {
  RxInt tabIndex = 0.obs;

  final List<Widget> pages = [
    HomeScreen(),
    BookmarkScreen(),
    CategoriesScreen(),
    RecipeAIScreen(),
  ];

  @override
  void onInit() {
    setUserFirebaseAnalyticsID();
    super.onInit();
  }

  Future<void> setUserFirebaseAnalyticsID() async {
    await FirebaseAnalytics.instance.setUserId(
      id: Get.find<HomeController>().user?.id,
    );
  }

  void changeTab(int value) {
    tabIndex.value = value;
    update();
  }
}
