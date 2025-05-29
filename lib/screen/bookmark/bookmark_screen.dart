import '../../util/app_export.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

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
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 10,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () => Get.toNamed(RouteHelper.recipeDetail),
            child: SizedBox(
              height: 150.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      Assets.images.foodImage.path,
                      fit: BoxFit.cover,
                      height: 150.h,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: titleWidth,
                          child: Text(
                            'Spice roasted chicken with flavored rice',
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
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: SvgPicture.asset(
                            Assets.icons.bookmarkSelectedIcon.path,
                            height: 16.h,
                            width: 16.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 15.h,),
          );
        },
      ),
    );
  }
}
