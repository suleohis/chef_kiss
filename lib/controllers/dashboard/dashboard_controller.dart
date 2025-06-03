import 'package:recipe_app/screen/categories/categories_screen.dart';
import 'package:recipe_app/util/controller_export.dart';

import '../../screen/bookmark/bookmark_screen.dart';
import '../../screen/home/home_screen.dart';

class DashboardController extends GetxController {
  RxInt tabIndex = 0.obs;

  final List<Widget> pages = [HomeScreen(), BookmarkScreen(), CategoriesScreen()];

  changeTab(int value) {
    tabIndex.value = value;
    update();
  }
}