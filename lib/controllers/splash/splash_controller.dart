import '../../util/controller_export.dart';
import '../home/home_controller.dart';

class SplashController extends GetxController{
  UserModel? user;
  Future<void> startCookingButton() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      user = await StorageHelper.getUser();
      Get.put(HomeController());
      // To reload for token for Recipe AI to work
      currentUser.reload();
      Get.offNamed(RouteHelper.initial);
    } else {
      Get.offNamed(RouteHelper.login);
    }
  }
}