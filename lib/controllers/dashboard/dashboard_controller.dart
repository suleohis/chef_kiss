import 'package:recipe_app/util/controller_export.dart';

import '../../screen/bookmark/bookmark_screen.dart';
import '../../screen/home/home_screen.dart';
import '../../screen/notification/notification_screen.dart';
import '../../screen/profile/profile_screen.dart';

class DashboardController extends GetxController {
  RxInt tabIndex = 0.obs;

  final List<Widget> pages = [HomeScreen(), BookmarkScreen(), NotificationScreen(), ProfileScreen()];

  changeTab(int value) {
    tabIndex.value = value;
    update();
  }
}