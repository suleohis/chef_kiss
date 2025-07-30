part of '../home_screen.dart';

class HomeHeadersWidget extends StatelessWidget {
  final SearchMealController controller = Get.put(SearchMealController());
  HomeHeadersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'hello'.tr} ${home.user?.name ?? ''}',
                      style: TextStyles.bold.copyWith(fontSize: 20),
                    ),
                    Text(
                      'cooking_today'.tr,
                      style: TextStyles.normal.copyWith(fontSize: 11),
                    ),
                  ],
                ),
                CustomPopup(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.find<HomeController>().logout(),
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          children: [
                            Icon(Icons.logout).paddingOnly(right: 5.w),
                            Text('logout'.tr, style: TextStyles.normal),
                          ],
                        ),
                      ).paddingAll(5),
                      GestureDetector(
                        onTap: () => Get.find<HomeController>().deleteDialog(),
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_forever,
                              color: ColorsUtil.red,
                            ).paddingOnly(right: 5.w),
                            Text(
                              'delete_all_user_data'.tr,
                              style: TextStyles.normal.copyWith(
                                color: ColorsUtil.red,
                              ),
                            ),
                          ],
                        ),
                      ).paddingAll(5),
                    ],
                  ),
                  child: Icon(Icons.more_vert),
                ),
              ],
            ).paddingOnly(bottom: 20.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    onTap: () => controller.openedFilterFun(),
                    padding: EdgeInsets.zero,
                    enabled: false,
                    prefix: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 18,
                      color: ColorsUtil.grey,
                    ).paddingSymmetric(horizontal: 10.w),
                    hint: 'search_recipe'.tr,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.openedFilterFun(true),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: ColorsUtil.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      FontAwesomeIcons.filter,
                      color: ColorsUtil.white,
                      size: 20,
                    ),
                  ).paddingOnly(left: 20.w),
                ),
              ],
            ).paddingOnly(bottom: 20.h),

            Obx(
              () => Center(
                child: CustomButton(
                  onPressed:
                      () => Get.find<HomeController>().randomFoodLookup(),
                  text: 'try_something'.tr,
                  background: ColorsUtil.primary,
                  foreground: ColorsUtil.white,
                  isLoading: Get.find<HomeController>().isLoadingRandom.value,
                  size: Size(243.w, 54.h),
                ).paddingOnly(bottom: 20.h),
              ),
            ),
          ],
        );
      },
    );
  }
}
