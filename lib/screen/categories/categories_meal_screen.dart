import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipe_app/controllers/home/home_controller.dart';
import '../../controllers/categories/categories_controller.dart';
import '../../util/app_export.dart';

part 'widgets/categories_meal_shimmer.dart';

class CategoriesMealScreen extends StatelessWidget {
  CategoriesMealScreen({super.key});
  final CategoriesController controller = Get.find<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'categories_meals'.tr,
          style: TextStyles.semiBold.copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: GetBuilder<CategoriesController>(
          builder: (controller) {
            return controller.isLoadingMeal
                ? CategoriesMealShimmer()
                : controller.meals.isEmpty
                ? Center(
                  child: Text(
                    'empty_list'.tr,
                    style: TextStyles.bold.copyWith(
                      fontSize: 24.sp,
                      color: ColorsUtil.primary,
                    ),
                  ),
                ).paddingSymmetric(horizontal: 30.w, vertical: 30.h)
                : AlignedGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                  ),
                  itemCount: controller.meals.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap:
                          () => Get.toNamed(
                            RouteHelper.recipeDetail,
                            arguments: {
                              'mealId': controller.meals[index].idMeal!,
                            },
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      controller.meals[index].strMealThumb ??
                                      '',
                                  height: 150.h,
                                  width: double.maxFinite.w,
                                  fit: BoxFit.cover,
                                  errorWidget:
                                      (_, url, error) => Image.asset(
                                        Assets.images.noImage.path,
                                        height: 150.h,
                                        fit: BoxFit.cover,
                                      ),
                                ).paddingOnly(bottom: 5.h),
                                if (Get.find<HomeController>().user?.bookmark
                                        .contains(
                                          controller.meals[index].idMeal,
                                        ) ??
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
                                        borderRadius: BorderRadius.circular(
                                          100.r,
                                        ),
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.icons.bookmarkSelectedIcon.path,
                                        height: 16.h,
                                        width: 16.w,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            controller.meals[index].strMeal ?? '',
                            maxLines: 2,
                            style: TextStyles.semiBold.copyWith(
                              fontSize: 12.sp,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
