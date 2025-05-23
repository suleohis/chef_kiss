import '../../util/controller_export.dart';

class SplashController extends GetxController{
  startCookingButton() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      Get.offNamed(RouteHelper.initial);
    } else {
      Get.offNamed(RouteHelper.login);
    }
  }
}