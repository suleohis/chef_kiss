import '../../util/controller_export.dart';

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool accept = false;
  bool hidePassword = true;
  bool cHidePassword = true;

  updateHidePassword() {
    hidePassword = !hidePassword;
    update();
  }

  updateCHidePassword() {
    cHidePassword = !cHidePassword;
    update();
  }

  updateAccept() {
    accept = !accept;
    update();
  }

  Future<UserModel?> signUp() async {
    if (!loginKey.currentState!.validate()) {
      return null;
    }
    try {
      isLoading = true;
      update();
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .catchError((e) {
            throw e;
          });

      if (credential.user != null) {
        User user = credential.user!;
        UserModel userModel = UserModel(
          id: user.uid,
          email: emailController.text,
          name: nameController.text,
          bookmark: [],
        );
        await FirebaseUtil.users.doc(user.uid).set(userModel.to()).catchError((
          e,
        ) {
          throw e;
        });

        isLoading = false;
        update();
        success(
          context: Get.context!,
          title: 'success'.tr,
          message: 'signup_successful'.tr,
        );
        StorageHelper.saveUser(userModel);
        Get.offAllNamed(RouteHelper.initial);
        return userModel;
      }
      error(
        context: Get.context!,
        title: 'signUp_failed'.tr,
        message: 'something_wrong'.tr,
      );
      isLoading = false;
      update();
      return null;
    } catch (e) {
      error(
        context: Get.context!,
        title: 'signUp_failed'.tr,
        message: e.toString(),
      );
      printError(e);
      isLoading = false;
      update();
      return null;
    }
  }
}
