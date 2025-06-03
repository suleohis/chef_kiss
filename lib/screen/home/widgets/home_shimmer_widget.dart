part of '../home_screen.dart';

class HomeCategoryShimmerWidget extends StatelessWidget {
  const HomeCategoryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer(
          child: Container(
            height: 31.h,
            width: 50.w,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 7.h,
            ),
            decoration: BoxDecoration(
              color: ColorsUtil.greyBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ).paddingOnly(right: 10.w);
      },
    );
  }
}

class HomeMealShimmerWidget extends StatelessWidget {
  const HomeMealShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 15.w,
      mainAxisSpacing: 15.h,
      itemCount: 10,
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
