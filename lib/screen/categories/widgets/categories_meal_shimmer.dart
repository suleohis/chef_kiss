part of '../categories_meal_screen.dart';

class CategoriesMealShimmer extends StatelessWidget {
  const CategoriesMealShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 15.w,
      mainAxisSpacing: 15.h,
      itemCount: 10,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              child: Container(
                height: 150.h,
                decoration: BoxDecoration(
                    color: ColorsUtil.greyBg,
                    borderRadius: BorderRadius.circular(10.r)
                ),
              ),
            ).paddingOnly(bottom: 5.h),
            Shimmer(
              child: Container(
                height: 20.h,
                decoration: BoxDecoration(
                  color: ColorsUtil.greyBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}