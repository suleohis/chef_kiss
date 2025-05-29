import 'package:recipe_app/controllers/recipe_detail/recipe_detail_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../util/app_export.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeDetailController controller = Get.find<RecipeDetailController>();
  RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: ColorsUtil.primary),
            icon: Icon(Icons.bookmark_outline_rounded),
            label: Text(
              'unsaved'.tr,
              style: TextStyles.normal.copyWith(fontSize: 14.sp),
            ),
          ).paddingOnly(right: 20.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Youtube Vide
            SizedBox(
              height: 150.h,
              width: 500.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: YoutubePlayer(
                  controller: controller.youtubeController,
                  liveUIColor: ColorsUtil.primary,
                ),
              ),
            ),

            ///Recipe Info
            Text(
              'Spice roasted chicken with flavored rice',
              maxLines: 10,
              textAlign: TextAlign.center,
              style: TextStyles.semiBold.copyWith(
                fontSize: 16.sp,
                overflow: TextOverflow.ellipsis,
                color: ColorsUtil.black,
              ),
            ).paddingOnly(top: 20.h),
            RichText(
              text: TextSpan(
                text: '${'category'.tr}: ',
                style: TextStyles.normal.copyWith(fontSize: 13.sp),
                children: [
                  TextSpan(
                    text: 'Vegetarian',
                    style: TextStyles.semiBold.copyWith(fontSize: 13.sp),
                  ),
                ],
              ),
            ),

            RichText(
              text: TextSpan(
                text: '${'area'.tr}: ',
                style: TextStyles.normal.copyWith(fontSize: 13.sp),
                children: [
                  TextSpan(
                    text: 'Italian',
                    style: TextStyles.semiBold.copyWith(fontSize: 13.sp),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 10.h),

            ///Detail
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 58.h,
                    child: TabBar(
                      onTap: (index) => controller.onTabIndex(index),
                      dividerHeight: 0,
                      indicatorColor: ColorsUtil.primary,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: ColorsUtil.primary,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyles.semiBold.copyWith(
                        fontSize: 11.sp,
                        color: ColorsUtil.white,
                      ),
                      unselectedLabelStyle: TextStyles.semiBold.copyWith(
                        fontSize: 11.sp,
                        color: ColorsUtil.primary,
                      ),
                      tabs: [
                        Tab(text: "ingredient".tr),
                        Tab(text: "procedure".tr),
                      ],
                    ).paddingOnly(bottom: 15.h),
                  ),
                  Obx(
                    () =>
                        controller.tabIndex.value == 0
                            ? Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    '10 ${'items'.tr}',
                                    style: TextStyles.normal.copyWith(
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ).paddingOnly(bottom: 15.h),
                                ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, index) {
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        color: ColorsUtil.greyBg,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tomatoes',
                                            style: TextStyles.semiBold.copyWith(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          Text(
                                            '500g',
                                            style: TextStyles.normal.copyWith(
                                              fontSize: 14.sp,
                                              color: ColorsUtil.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).paddingOnly(bottom: 10.h);
                                  },
                                ),
                              ],
                            )
                            : Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: ColorsUtil.greyBg,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${'instruction'.tr}:',
                                        style: TextStyles.semiBold.copyWith(
                                          fontSize: 14.sp,
                                        ),
                                      ).paddingOnly(bottom: 5.h),
                                      Text(
                                        'Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta. Cook according to the package instructions, about 9 minutes.\r\nIn a large skillet over medium-high heat, add the olive oil and heat until the oil starts to shimmer. Add the garlic and cook, stirring, until fragrant, 1 to 2 minutes. Add the chopped tomatoes, red chile flakes, Italian seasoning and salt and pepper to taste. Bring to a boil and cook for 5 minutes. Remove from the heat and add the chopped basil.\r\nDrain the pasta and add it to the sauce. Garnish with Parmigiano-Reggiano flakes and more basil and serve warm.',
                                        style: TextStyles.normal.copyWith(
                                          fontSize: 13.sp,
                                          color: ColorsUtil.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).paddingSymmetric(vertical: 15.h),
                              ],
                            ),
                  ).paddingOnly(bottom: 15.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
