import '../../util/app_export.dart';

class HomeController extends GetxController {
  openedFilterFun([bool open = false]) {
    Get.toNamed(RouteHelper.searchRecipe);
    if (open) {
      Future.delayed(
        Duration(milliseconds: 500),
        () => filterWidget(Get.context!),
      );
    }
  }

  Future<dynamic> filterWidget(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'filter_search'.tr,
                    style: TextStyles.semiBold.copyWith(fontSize: 14.sp),
                  ),
                ).paddingOnly(bottom: 15.h),
                Text(
                  'category'.tr,
                  style: TextStyles.semiBold.copyWith(fontSize: 14),
                ).paddingOnly(bottom: 10.h),
                Wrap(
                  children: List.generate(10, (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            index == 0
                                ? ColorsUtil.primary
                                : Colors.transparent,
                        border: Border.all(color: ColorsUtil.primary),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'All',
                        style: TextStyles.normal.copyWith(
                          fontSize: 11.sp,
                          color:
                              index == 0
                                  ? ColorsUtil.white
                                  : ColorsUtil.primary,
                        ),
                      ),
                    ).paddingOnly(right: 10.w, bottom: 10.h);
                  }),
                ).paddingOnly(bottom: 5.h),

                Text(
                  'area'.tr,
                  style: TextStyles.semiBold.copyWith(fontSize: 14),
                ).paddingOnly(bottom: 10.h),
                Wrap(
                  children: List.generate(10, (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            index == 0
                                ? ColorsUtil.primary
                                : Colors.transparent,
                        border: Border.all(color: ColorsUtil.primary),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Canadian',
                        style: TextStyles.normal.copyWith(
                          fontSize: 11.sp,
                          color:
                              index == 0
                                  ? ColorsUtil.white
                                  : ColorsUtil.primary,
                        ),
                      ),
                    ).paddingOnly(right: 10.w, bottom: 10.h);
                  }),
                ).paddingOnly(bottom: 5.h),

                Text(
                  'ingredients'.tr,
                  style: TextStyles.semiBold.copyWith(fontSize: 14),
                ).paddingOnly(bottom: 10.h),
                Wrap(
                  children: List.generate(10, (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            index == 0
                                ? ColorsUtil.primary
                                : Colors.transparent,
                        border: Border.all(color: ColorsUtil.primary),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Chicken',
                        style: TextStyles.normal.copyWith(
                          fontSize: 11.sp,
                          color:
                              index == 0
                                  ? ColorsUtil.white
                                  : ColorsUtil.primary,
                        ),
                      ),
                    ).paddingOnly(right: 10.w, bottom: 10.h);
                  }),
                ).paddingOnly(bottom: 5.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
