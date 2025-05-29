part of '../home_screen.dart';

class HomeHeadersWidget extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  HomeHeadersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${'hello'.tr} John', style: TextStyles.bold.copyWith(fontSize: 20), ),
                Text('cooking_today'.tr, style: TextStyles.normal.copyWith(fontSize: 11), ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                Assets.images.noProfile.path,
                height: 40.h, width: 40.w,
              ),
            )
          ],
        ).paddingOnly(bottom: 20.h),
        Row(
          children: [
            Expanded(child: CustomTextField(
              onTap: () => controller.openedFilterFun(),
              padding: EdgeInsets.zero,
              prefix: Icon(FontAwesomeIcons.magnifyingGlass, size: 18, color: ColorsUtil.grey,).paddingSymmetric(horizontal: 10.w),
              hint: 'search_recipe'.tr,
            )),
            GestureDetector(
              onTap: () => controller.openedFilterFun(true),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: ColorsUtil.primary,
                    borderRadius: BorderRadius.circular(10.r)
                ),
                child: Icon(FontAwesomeIcons.filter, color: ColorsUtil.white, size: 20,),
              ).paddingOnly(left: 20.w),
            )
          ],
        ).paddingOnly(bottom: 20.h)
      ],
    );
  }
}
