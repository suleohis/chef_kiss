import '../../util/controller_export.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> forgotKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> sendResetLink() async {
    if (!forgotKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading = true;
      update();
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .catchError((e) {
            throw e;
          });
      success(
        context: Get.context!,
        title: 'success'.tr,
        message: 'successful_reset_password'.tr,
      );
      isLoading = false;
      update();
      Get.offAllNamed(RouteHelper.login);
    } catch (e) {
      error(
        context: Get.context!,
        title: 'reset_failed'.tr,
        message: e.toString(),
      );
      printError(e);
      isLoading = false;
      update();
    }
  }
}
