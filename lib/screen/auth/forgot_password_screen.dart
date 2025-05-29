import 'package:email_validator/email_validator.dart';

import '../../controllers/forgot_password/forgot_password_controller.dart';
import '../../util/app_export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'forgot_password_title'.tr,
              style: TextStyles.semiBold.copyWith(fontSize: 20.sp),
            ),

            Text(
              'forgot_password_subtitle'.tr,
              style: TextStyles.normal.copyWith(fontSize: 11.sp),
            ).paddingOnly(bottom: 20.h),
            /// Email
            Form(
                key: controller.forgotKey,
                child:
            CustomTextField(
              hint: 'enter_email'.tr,
              label: 'email'.tr,
              controller: controller.emailController,
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
            )).paddingOnly(bottom: 20.h),

            Center(
              child: CustomButton(
                onPressed: () {
                  controller.sendResetLink();
                },
                text: 'send_reset_link'.tr,
                isLoading: controller.isLoading,
                suffix: Icon(
                  Icons.arrow_forward,
                  size: 16.sp,
                  color: ColorsUtil.white,
                ).paddingOnly(left: 10.w),
                background: ColorsUtil.primary,
                foreground: ColorsUtil.white,
                size: Size(243.w, 54.h),
              ).paddingOnly(bottom: 20.h),
            ),
          ],
        ),
      ),
    );
  }
}
