import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipe_app/controllers/search/search_meal_controller.dart';
import 'package:recipe_app/data/models/filtered_meal.dart';

import '../../controllers/home/home_controller.dart';
import '../../util/app_export.dart';

class SearchRecipesScreen extends StatelessWidget {
  final SearchMealController controller = Get.put(SearchMealController());
  SearchRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'search_recipes'.tr,
          style: TextStyles.semiBold.copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: GetBuilder<SearchMealController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: controller.searchController,
                          onChanged: (value) => controller.searchMeal(value),
                          padding: EdgeInsets.zero,
                          prefix: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 18,
                            color: ColorsUtil.grey,
                          ).paddingSymmetric(horizontal: 10.w),
                          hint: 'search_recipe'.tr,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.filterWidget(context),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'search_result'.tr,
                        style: TextStyles.semiBold.copyWith(fontSize: 16.sp),
                      ),
                      Text(
                        '${controller.meals.length} ${'results'.tr}',
                        style: TextStyles.normal.copyWith(
                          fontSize: 11.sp,
                          color: ColorsUtil.grey,
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 20),
                  controller.meals.isEmpty
                      ? Center(
                        child: Text(
                          'empty_list'.tr,
                          style: TextStyles.bold.copyWith(
                            fontSize: 24.sp,
                            color: ColorsUtil.primary,
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 30.w, vertical: 30.h)
                      : Expanded(
                        child: AlignedGridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 15.h,
                          itemCount:
                              controller.searchController.text.isNotEmpty
                                  ? controller.filterMeals.length
                                  : controller.meals.length,
                          itemBuilder: (context, index) {
                            FilteredMealItem data =
                                controller.searchController.text.isNotEmpty
                                    ? controller.filterMeals[index]
                                    : controller.meals[index];
                            return GestureDetector(
                              onTap:
                                  () => Get.toNamed(
                                    RouteHelper.recipeDetail,
                                    arguments: {'mealId': data.idMeal!},
                                  ),
                              child: Container(
                                height: 150.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: data.strMealThumb ?? '',
                                        fit: BoxFit.cover,
                                        height: 150.h,
                                        errorWidget:
                                            (_, url, error) => Image.asset(
                                              Assets.images.noImage.path,
                                              height: 150.h,
                                              fit: BoxFit.cover,
                                            ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        height: 150.h,
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              ColorsUtil.black.withValues(
                                                alpha: .0,
                                              ),
                                              ColorsUtil.black,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Text(
                                          data.strMeal ?? '',
                                          maxLines: 2,
                                          style: TextStyles.semiBold.copyWith(
                                            fontSize: 11.sp,
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorsUtil.white,
                                          ),
                                        ),
                                      ),
                                      if (Get.find<HomeController>()
                                              .user
                                              ?.bookmark
                                              .contains(data.idMeal) ??
                                          false)
                                        Positioned(
                                          right: 8.w,
                                          top: 8.h,
                                          child: Container(
                                            height: 24.h,
                                            width: 24.w,
                                            padding: EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: ColorsUtil.white,
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                            ),
                                            child: SvgPicture.asset(
                                              Assets
                                                  .icons
                                                  .bookmarkSelectedIcon
                                                  .path,
                                              height: 16.h,
                                              width: 16.w,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
