part of '../recipe_detail_screen.dart';

class RecipeDetailShimmer extends StatelessWidget {
  const RecipeDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Youtube Vide
          Shimmer(
            child: Container(
              height: 150.h,
              width: 500.w,
              decoration: BoxDecoration(
                color: ColorsUtil.greyBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ).paddingOnly(bottom: 10.h),

          ///Recipe Info
          Shimmer(
            child: Container(
              height: 20.h,
              width: size.width * .8,
              decoration: BoxDecoration(
                color: ColorsUtil.greyBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ).paddingOnly(bottom: 10.h),

          Shimmer(
            child: Container(
              height: 20.h,
              width: size.width * .5,
              decoration: BoxDecoration(
                color: ColorsUtil.greyBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ).paddingOnly(bottom: 10),

          Shimmer(
            child: Container(
              height: 20.h,
              width: size.width * .5,
              decoration: BoxDecoration(
                color: ColorsUtil.greyBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ).paddingOnly(bottom: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Shimmer(
                child: Container(
                  height: 30.h,
                  width: size.width * .4,
                  constraints: BoxConstraints(maxWidth: 250.w),
                  decoration: BoxDecoration(
                      color: ColorsUtil.greyBg,
                      borderRadius: BorderRadius.circular(10.r)
                  ),
                ),
              ),

              Shimmer(
                child: Container(
                  height: 30.h,
                  width: size.width * .4,
                  constraints: BoxConstraints(maxWidth: 250.w),
                  decoration: BoxDecoration(
                      color: ColorsUtil.greyBg,
                      borderRadius: BorderRadius.circular(10.r)
                  ),
                ),
              ),
            ],
          ).paddingOnly(bottom: 15.h),

          Align(
            alignment: Alignment.topRight,
                child: Shimmer(
                  child: Container(
                    height: 17.h,
                    width: size.width * .4,
                    constraints: BoxConstraints(maxWidth: 250.w),
                    decoration: BoxDecoration(
                        color: ColorsUtil.greyBg,
                        borderRadius: BorderRadius.circular(10.r)
                    ),
                  ),
                ),
              ).paddingOnly(bottom: 15.h),

          ///Detail
          ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return
                Shimmer(
                  child: Container(
                    height: 76.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: ColorsUtil.greyBg,
                        borderRadius: BorderRadius.circular(10.r)
                    ),
                  ),
                ).paddingOnly(bottom: 10.h);
            },
          ),
        ],
      ),
    );
  }
}
