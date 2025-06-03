part of '../recipe_detail_screen.dart';

class RecipeDetailBody extends StatelessWidget {
  const RecipeDetailBody({super.key, required this.controller});

  final RecipeDetailController controller;

  @override
  Widget build(BuildContext context) {
    Meal meal = controller.meal!;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Youtube Vide0
          RecipeDetailVideoWidget(
            meal: meal,
            youtubeController: controller.youtubeController,
          ),

          ///Recipe Info
          Text(
            meal.strMeal ?? '',
            maxLines: 10,
            textAlign: TextAlign.center,
            style: TextStyles.semiBold.copyWith(
              fontSize: 16.sp,
              overflow: TextOverflow.ellipsis,
              color: ColorsUtil.black,
            ),
          ).paddingOnly(top: 10.h),
          RichText(
            text: TextSpan(
              text: '${'category'.tr}: ',
              style: TextStyles.normal.copyWith(fontSize: 13.sp),
              children: [
                TextSpan(
                  text: meal.strCategory ?? '',
                  style: TextStyles.semiBold.copyWith(fontSize: 13.sp),
                ),
              ],
            ),
          ).paddingSymmetric(vertical: 5.h),

          RichText(
            text: TextSpan(
              text: '${'area'.tr}: ',
              style: TextStyles.normal.copyWith(fontSize: 13.sp),
              children: [
                TextSpan(
                  text: meal.strArea ?? '',
                  style: TextStyles.semiBold.copyWith(fontSize: 13.sp),
                ),
              ],
            ),
          ).paddingOnly(bottom: 20.h),

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
                                  '${meal.mealIngredients?.length ?? 0} ${'items'.tr}',
                                  style: TextStyles.normal.copyWith(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ).paddingOnly(bottom: 15.h),
                              meal.mealIngredients?.isEmpty ?? true
                                  ? Center(
                                    child: Text(
                                      'empty_list'.tr,
                                      style: TextStyles.bold.copyWith(
                                        fontSize: 24.sp,
                                        color: ColorsUtil.primary,
                                      ),
                                    ),
                                  ).paddingSymmetric(
                                    horizontal: 30.w,
                                    vertical: 30.h,
                                  )
                                  : ListView.builder(
                                    itemCount:
                                        meal.mealIngredients?.length ?? 0,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      MealIngredient mealIngredient =
                                          meal.mealIngredients![index];
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          color: ColorsUtil.greyBg,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: ColorsUtil.white,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${ConstUtil.ingredientsImageUrl}'
                                                    '${mealIngredient.ingredient.replaceAll(' ', '%20')}.png',
                                                height: 52.h,
                                                width: 52.w,
                                                errorWidget:
                                                    (_, url, error) =>
                                                        Image.asset(
                                                          Assets
                                                              .images
                                                              .noImage
                                                              .path,
                                                          height: 52.h,
                                                          width: 52.w,
                                                          fit: BoxFit.cover,
                                                        ),
                                                fit: BoxFit.cover,
                                              ),
                                            ).paddingOnly(right: 15.w),
                                            Text(
                                              mealIngredient.ingredient,
                                              style: TextStyles.semiBold
                                                  .copyWith(fontSize: 16.sp),
                                            ),
                                            Spacer(),
                                            Text(
                                              mealIngredient.measure,
                                              style: TextStyles.normal.copyWith(
                                                fontSize: 14.sp,
                                                color:
                                                    ColorsUtil.unselectedItem,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${'instruction'.tr}:',
                                      style: TextStyles.semiBold.copyWith(
                                        fontSize: 15.sp,
                                      ),
                                    ).paddingOnly(bottom: 5.h),
                                    Text(
                                      meal.strInstructions ?? '',
                                      style: TextStyles.normal.copyWith(
                                        fontSize: 14.sp,
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
    );
  }
}
