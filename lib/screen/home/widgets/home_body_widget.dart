part of '../home_screen.dart';

class HomeBodyWidget extends StatelessWidget {
  final HomeController c = Get.put(HomeController());
  HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Categories
            SizedBox(
              height: 31.h,
              child:
                  controller.isLoadingCategory
                      ? HomeCategoryShimmerWidget()
                      : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          bool isSelected = index == controller.catIndex;
                          return GestureDetector(
                            onTap: () => controller.selectCategory(index),
                            child: Container(
                              height: 31.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 7.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? ColorsUtil.primary
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                controller.categories[index].strCategory ?? '',
                                style: TextStyles.semiBold.copyWith(
                                  fontSize: 11.sp,
                                  color:
                                      isSelected
                                          ? ColorsUtil.white
                                          : ColorsUtil.primary,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ).paddingOnly(bottom: 20.h),

            /// Meals
            controller.isLoadingCategory
                ? HomeMealShimmerWidget()
                : AlignedGridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  itemCount: controller.meals.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.toNamed(RouteHelper.recipeDetail),
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
                                  height: 124.h,
                                  fit: BoxFit.fill,
                                ).paddingOnly(bottom: 5.h),
                                if (controller.user?.bookmark.contains(controller.meals[index].idMeal) ?? false)
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
                ),
          ],
        );
      },
    );
  }
}
