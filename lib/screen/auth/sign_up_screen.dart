
import 'package:email_validator/email_validator.dart';
import 'package:recipe_app/controllers/login/login_controller.dart';
import 'package:recipe_app/controllers/signup/signup_controller.dart';

import '../../util/app_export.dart';

class SignUpScreen extends StatelessWidget {
  final SignupController signUpController = Get.put(SignupController());
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SignupController>(
            builder: (_) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'create_an_account'.tr,
                        style: TextStyles.semiBold.copyWith(fontSize: 20.sp),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'sign_up_note'.tr,
                        style: TextStyles.normal.copyWith(fontSize: 11.sp),
                      ).paddingOnly(bottom: 20.h),
                    ),
                    Form(
                      key: signUpController.loginKey,
                      child: Column(
                        children: [
                          /// Name
                          CustomTextField(
                            hint: 'enter_name'.tr,
                            label: 'name'.tr,
                            controller: signUpController.nameController,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_name'.tr;
                              }
                              return null;
                            },
                          ).paddingOnly(bottom: 15.h),

                          /// Email
                          CustomTextField(
                            hint: 'enter_email'.tr,
                            label: 'email'.tr,
                            controller: signUpController.emailController,
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
                          ).paddingOnly(bottom: 15.h),

                          /// Password
                          CustomTextField(
                            hint: 'enter_password'.tr,
                            label: 'password'.tr,
                            controller: signUpController.passwordController,
                            hidePassword: signUpController.hidePassword,
                            suffix: GestureDetector(
                              onTap: () => signUpController.updateHidePassword,
                              child: Icon(
                                signUpController.hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorsUtil.primary,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_password'.tr;
                              } else if (value.length < 8) {
                                return "password_length_limit".tr;
                              }
                              return null;
                            },
                          ).paddingOnly(bottom: 15.h),

                          /// Confirm Password
                          CustomTextField(
                            hint: 'retype_password'.tr,
                            label: 'confirm_password'.tr,
                            controller: signUpController.cPasswordController,
                            hidePassword: signUpController.cHidePassword,
                            suffix: GestureDetector(
                              onTap: () => signUpController.updateCHidePassword,
                              child: Icon(
                                signUpController.cHidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorsUtil.primary,
                              ),
                            ),
                            validator: (value) {
                              if (value != signUpController.passwordController.text) {
                                return 'password_not_com_password'.tr;
                              }
                              return null;
                            },
                          ).paddingOnly(bottom: 5.h),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: signUpController.accept,
                        onChanged: (value) {
                          signUpController.updateAccept();
                        },
                        checkboxShape: RoundedRectangleBorder(
                          side: BorderSide(color: ColorsUtil.secondary),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        title: Text(
                          'accept_term'.tr,
                          style: TextStyles.normal.copyWith(
                            fontSize: 11.sp,
                            color: ColorsUtil.secondary,
                          ),
                        ),
                      ).paddingOnly(bottom: 5.h),
                    ),

                    CustomButton(
                      onPressed: () {
                        signUpController.signUp();
                      },
                      text: 'sign_in'.tr,
                      disable: !signUpController.accept,
                      isLoading: signUpController.isLoading,
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
                    GetBuilder<LoginController>(builder: (loginController) =>
                        Wrap(
                          children: [
                            GestureDetector(
                            onTap: () => loginController.googleLogin(),
                              child: Image.asset(
                                Assets.images.googleButton.path,
                                width: 50.w,
                                height: 50.h,
                              ).paddingOnly(right: 20.w),
                            ),
                            GestureDetector(
                              onTap: () => loginController.facebookLogin(),
                              child: Image.asset(
                                Assets.images.facebookButton.path,
                                width: 50.w,
                                height: 50.h,
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 15.h),),
                    Wrap(
                      children: [
                        Text(
                          'already_a_member'.tr,
                          style: TextStyles.medium.copyWith(fontSize: 11),
                        ),
                        GestureDetector(
                          onTap: () => Get.offNamed(RouteHelper.login),
                          child: Text(
                            'sign_in'.tr,
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
          }
        ),
      ),
    );
  }
}
