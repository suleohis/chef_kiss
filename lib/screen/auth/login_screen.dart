import 'package:email_validator/email_validator.dart';
import 'package:recipe_app/controllers/login/login_controller.dart';

import '../../util/app_export.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LoginController>(
          builder: (_) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * .08,
                  horizontal: 20.sp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'hello'.tr,
                        style: TextStyles.bold.copyWith(fontSize: 30.sp),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'welcome_back'.tr,
                        style: TextStyles.normal.copyWith(fontSize: 30.sp),
                      ).paddingOnly(bottom: 50.h),
                    ),

                    Form(
                      key: loginController.loginKey,
                      child: Column(
                        children: [
                          ///Email
                          CustomTextField(
                            controller: loginController.emailController,
                            hint: 'enter_email'.tr,
                            label: 'email'.tr,
                            textInputType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_email'.tr;
                              } else if (!EmailValidator.validate(value)) {
                                return 'please_valid_email'.tr;
                              }
                              return null;
                            },
                          ).paddingOnly(bottom: 20.h),

                          ///Password
                          CustomTextField(
                            controller: loginController.passwordController,
                            hint: 'enter_password'.tr,
                            label: 'password'.tr,
                            hidePassword: loginController.hidePassword,
                            suffix: GestureDetector(
                              onTap: () => loginController.updateHidePassword(),
                              child: Icon(
                                loginController.hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorsUtil.primary,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_password'.tr;
                              }
                              return null;
                            },
                          ).paddingOnly(bottom: 15.h),
                        ],
                      ),
                    ),

                    ///Forget Password
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () => Get.toNamed(RouteHelper.forgotPassword),
                        child: Text(
                          'forgot_password'.tr,
                          style: TextStyles.normal.copyWith(
                            fontSize: 11.sp,
                            color: ColorsUtil.secondary,
                          ),
                        ),
                      ).paddingOnly(bottom: 15.h),
                    ),

                    ///Button
                    CustomButton(
                      onPressed: () {
                        loginController.login();
                      },
                      text: 'sign_in'.tr,
                      isLoading: loginController.isLoading,
                      suffix: Icon(
                        Icons.arrow_forward,
                        size: 16.sp,
                        color: ColorsUtil.white,
                      ).paddingOnly(left: 10.w),
                      background: ColorsUtil.primary,
                      foreground: ColorsUtil.white,
                      size: Size(243.w, 54.h),
                    ).paddingOnly(bottom: 20.h),

                    Wrap(
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: Divider(color: ColorsUtil.greyBg),
                        ),
                        Text(
                          'or_sign_in_with'.tr,
                          style: TextStyles.medium.copyWith(
                            fontSize: 11.sp,
                            color: ColorsUtil.greyBg,
                          ),
                        ).paddingSymmetric(horizontal: 10.w),
                        SizedBox(
                          width: 50.w,
                          child: Divider(color: ColorsUtil.greyBg),
                        ),
                      ],
                    ).paddingOnly(bottom: 10),

                    ///Social Login
                    Wrap(
                      children: [
                        GestureDetector(
                          onTap: () => loginController.googleLogin(),
                          child: Image.asset(
                            Assets.images.googleButton.path,
                            width: 50.w,
                            height: 50.h,
                          ),
                        ).paddingOnly(right: 20.w),
                        GestureDetector(
                          onTap: () => loginController.facebookLogin(),
                          child: Image.asset(
                            Assets.images.facebookButton.path,
                            width: 50.w,
                            height: 50.h,
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 25.h),
                    Wrap(
                      children: [
                        Text(
                          'dont_have_an_account'.tr,
                          style: TextStyles.medium.copyWith(fontSize: 11),
                        ),
                        GestureDetector(
                          onTap: () => Get.offNamed(RouteHelper.signUp),
                          child: Text(
                            'sign_up'.tr,
                            style: TextStyles.medium.copyWith(
                              fontSize: 11,
                              color: ColorsUtil.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
