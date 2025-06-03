import 'package:recipe_app/controllers/bookmark/bookmark_controller.dart';
import 'package:recipe_app/data/models/meal.dart';

import '../../util/app_export.dart';
part 'widgets/bookmark_shimmer.dart';

class BookmarkScreen extends StatelessWidget {
  final BookmarkController c = Get.put(BookmarkController());
  BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double titleWidth = (MediaQuery.of(context).size.width / 1.3) - 40.w;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'saved_recipes'.tr,
          style: TextStyles.semiBold.copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<BookmarkController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.onRefresh(),
            child:
                controller.isLoading
                    ? BookmarkShimmer()
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
                    : ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: controller.meals.length,
                      itemBuilder: (_, index) {
                        Meal data = controller.meals[index];
                        return GestureDetector(
                          onTap:
                              () => Get.toNamed(
                                RouteHelper.recipeDetail,
                                arguments: {'mealId': data.idMeal!},
                              ),
                          child: SizedBox(
                            height: 150.h,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: CachedNetworkImage(
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
                                ),

                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  height: 150.h,
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorsUtil.black.withValues(alpha: .0),
                                        ColorsUtil.black,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: titleWidth,
                                        child: Text(
                                          data.strMeal ?? '',
                                          maxLines: 2,
                                          style: TextStyles.semiBold.copyWith(
                                            fontSize: 14.sp,
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorsUtil.white,
                                          ),
                                        ),
                                      ).paddingOnly(right: 20.w),
                                      Container(
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
                                          Assets
                                              .icons
                                              .bookmarkSelectedIcon
                                              .path,
                                          height: 16.h,
                                          width: 16.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ).paddingOnly(bottom: 15.h),
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}
