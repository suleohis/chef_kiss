import 'package:recipe_app/controllers/splash/splash_controller.dart';
import 'package:recipe_app/util/app_export.dart';

class SplashScreen extends StatelessWidget {
  final SplashController controller = SplashController();
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            Assets.images.splash.path,
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * .08),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.images.splashLogo.path,
                          width: 79.w,
                          height: 79.h,
                        ).paddingOnly(bottom: 20),
                        Text(
                          'splash_logo_name'.tr,
                          style: TextStyles.bold.copyWith(fontSize: 18.sp, color: ColorsUtil.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'get_cooking'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyles.bold.copyWith(fontSize: 50.sp, color: ColorsUtil.white),
                        ).paddingOnly(bottom: 20),
                        Text(
                          'splash_note'.tr,
                          style: TextStyles.normal.copyWith(fontSize: 16.sp, color: ColorsUtil.white),
                        ).paddingOnly(bottom: 30),
                        CustomButton(
                          onPressed: () => controller.startCookingButton(),
                          text: 'start_cooking'.tr,
                          suffix: Icon(Icons.arrow_forward, size: 16.sp, color: ColorsUtil.white,),
                          background: ColorsUtil.primary,
                          foreground: ColorsUtil.white,
                          size: Size(243.w, 54.h),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
