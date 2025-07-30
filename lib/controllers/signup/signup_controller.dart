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

  void updateHidePassword() {
    hidePassword = !hidePassword;
    update();
  }

  void updateCHidePassword() {
    cHidePassword = !cHidePassword;
    update();
  }

  void updateAccept() {
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
          aiRecipes: [],
        );
        await FirebaseUtil.users.doc(user.uid).set(userModel.toJson()).catchError((
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
      isLoading = false;
      update();
      error(
        context: Get.context!,
        title: 'signUp_failed'.tr,
        message: 'something_wrong'.tr,
      );
      return null;
    } catch (e) {
      isLoading = false;
      update();
      error(
        context: Get.context!,
        title: 'signUp_failed'.tr,
        message: e.toString(),
      );
      printError(e);
      return null;
    }
  }
}
