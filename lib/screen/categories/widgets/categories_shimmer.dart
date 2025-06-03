part of '../categories_screen.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
      itemBuilder: (context, index) {
        return Card(
          color: ColorsUtil.white,
          child: Container(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(height: 180.h, color: ColorsUtil.greyBg),
                ).paddingOnly(bottom: 15.h),

                Shimmer(
                  child: Container(
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: ColorsUtil.greyBg,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ).paddingOnly(bottom: 10.h),
                Shimmer(
                  child: Column(
                    children: List.generate(5, (index) => Shimmer(
                      child: Container(
                        height: 15.h,
                        decoration: BoxDecoration(
                          color: ColorsUtil.greyBg,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ).paddingOnly(bottom: 3.h),
                    ),),
                  ),
                )
              ],
            ),
          ),
        ).paddingOnly(bottom: 20.h);
      },
    );
  }
}
