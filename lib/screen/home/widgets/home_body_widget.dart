part of '../home_screen.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 31.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                height: 31.h,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: index == 0 ? ColorsUtil.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  'All',
                  style: TextStyles.semiBold.copyWith(
                    fontSize: 11.sp,
                    color: index == 0 ? ColorsUtil.white : ColorsUtil.primary,
                  ),
                ),
              );
            },
          ),
        ).paddingOnly(bottom: 20.h),
        AlignedGridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 15.w,
          mainAxisSpacing: 15.h,
          itemCount: 10,
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
                        Image.asset(
                          Assets.images.foodImage.path,

                          height: 124.h,
                          fit: BoxFit.fill,
                        ).paddingOnly(bottom: 5.h),
                        if (index == 0)
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
                              borderRadius: BorderRadius.circular(100.r),
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
                    'Classic Greek Salad',
                    maxLines: 2,
                    style: TextStyles.semiBold.copyWith(
                      fontSize: 12.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
