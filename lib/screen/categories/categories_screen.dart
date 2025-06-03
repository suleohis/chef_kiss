import 'package:recipe_app/controllers/categories/categories_controller.dart';
import 'package:readmore/readmore.dart';

import '../../data/models/category.dart';
import '../../util/app_export.dart';
part 'widgets/categories_shimmer.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoriesController controller = Get.put(CategoriesController());
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'categories'.tr,
          style: TextStyles.semiBold.copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: GetBuilder<CategoriesController>(
          builder: (controller) {
            return controller.isLoadingCategory
                ? CategoriesShimmer()
                : controller.categories.isEmpty
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
                  itemCount: controller.categories.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 20.w,
                  ),
                  itemBuilder: (context, index) {
                    Category category = controller.categories[index];
                    return GestureDetector(
                      onTap: () => controller.onSelectedCategory(index),
                      child: Card(
                        color: ColorsUtil.white,
                        child: Container(
                          padding: EdgeInsets.all(20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CachedNetworkImage(
                                  imageUrl: category.strCategoryThumb ?? '',
                                  fit: BoxFit.cover,
                                  height: 180.h,
                                  errorWidget:
                                      (_, url, error) => Image.asset(
                                        Assets.images.noImage.path,
                                        height: 180.h,
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ).paddingOnly(bottom: 15.h),
                              Text(
                                category.strCategory ?? '',
                                style: TextStyles.bold.copyWith(
                                  fontSize: 20.sp,
                                ),
                              ),
                              ReadMoreText(
                                category.strCategoryDescription ?? '',
                                style: TextStyles.medium.copyWith(
                                  fontSize: 14.sp,
                                ),
                                trimMode: TrimMode.Line,
                                trimLines: 5,
                                colorClickableText: ColorsUtil.primary,
                                trimCollapsedText: 'show_more'.tr,
                                trimExpandedText: 'show_less'.tr,
                              ),
                            ],
                          ),
                        ),
                      ).paddingOnly(bottom: 20.h),
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
