import 'package:recipe_app/controllers/dashboard/dashboard_controller.dart';

import '../../util/app_export.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: ColorsUtil.homeBg,
          bottomNavigationBar: BottomAppBar(
            elevation: 9,
            shadowColor: Colors.black,
            color: ColorsUtil.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => controller.changeTab(0),
                  child: SvgPicture.asset(
                    controller.tabIndex.value == 0
                        ? Assets.icons.homeSelectedIcon.path
                        : Assets.icons.homeIcon.path,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.changeTab(1),
                  child: SvgPicture.asset(
                    controller.tabIndex.value == 1
                        ? Assets.icons.bookmarkSelectedIcon.path
                        : Assets.icons.bookmarkIcon.path,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.changeTab(2),
                  child: SvgPicture.asset(
                    controller.tabIndex.value == 2
                        ? Assets.icons.notifiSelectedIcon.path
                        : Assets.icons.notifiIcon.path,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.changeTab(3),
                  child: SvgPicture.asset(
                    controller.tabIndex.value == 3
                        ? Assets.icons.profileSelectedIcon.path
                        : Assets.icons.profileIcon.path,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
              ],
            ),
          ),
          body: controller.pages[controller.tabIndex.value],
        );
      }
    );
  }
}
