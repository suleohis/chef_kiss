import '../../util/controller_export.dart';

class SplashController extends GetxController{
  UserModel? user;
  startCookingButton() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      user = await StorageHelper.getUser();
      Get.offNamed(RouteHelper.initial);
    } else {
      Get.offNamed(RouteHelper.login);
    }
  }
}