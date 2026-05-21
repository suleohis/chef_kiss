import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../util/controller_export.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool hidePassword = true;

  void updateHidePassword() {
    hidePassword = !hidePassword;
    update();
  }

  Future<UserModel?> login() async {
    if (!loginKey.currentState!.validate()) {
      return null;
    }
    try {
      isLoading = true;
      update();
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .catchError((e) {
            throw e;
          });

      if (credential.user != null) {
        User user = credential.user!;

        DocumentSnapshot data = await FirebaseUtil.users
            .doc(user.uid)
            .get()
            .catchError((e) {
              throw e;
            });
        UserModel userModel = UserModel.from(
          data.data()! as Map<String, dynamic>,
        );
        isLoading = false;
        update();
        success(
          context: Get.context!,
          title: 'success'.tr,
          message: 'login_successful'.tr,
        );
        StorageHelper.saveUser(userModel);
        Get.offAllNamed(RouteHelper.initial);
        return userModel;
      }
      isLoading = false;
      update();
      error(
        context: Get.context!,
        title: 'login_failed'.tr,
        message: 'something_wrong'.tr,
      );
      return null;
    } catch (e) {
      isLoading = false;
      update();
      error(
        context: Get.context!,
        title: 'login_failed'.tr,
        message: e.toString(),
      );
      printError(e);
      return null;
    }
  }

  Future<UserModel?> googleLogin() async {
    try {
      isLoading = true;
      update();

      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Force a fresh account picker — prevents [16] reauth failed on Android
      await googleSignIn.signOut();
      GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      if (googleUser.email.isEmpty) throw 'something_wrong'.tr;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth
          .signInWithCredential(credential)
          .catchError((e) => throw e);

      if (userCredential.user != null) {
        User user = userCredential.user!;
        UserModel userModel = UserModel(
          id: user.uid,
          email: googleUser.email,
          name: googleUser.displayName ?? '',
          bookmark: [],
          aiRecipes: [],
        );

        final existing = await FirebaseUtil.users
            .where(ConstUtil.id, isEqualTo: user.uid)
            .get();

        if (existing.docs.isEmpty) {
          await FirebaseUtil.users.doc(user.uid).set(userModel.toJson());
          success(
            context: Get.context!,
            title: 'success'.tr,
            message: 'signup_successful'.tr,
          );
        } else {
          success(
            context: Get.context!,
            title: 'success'.tr,
            message: 'login_successful'.tr,
          );
        }

        isLoading = false;
        update();
        StorageHelper.saveUser(userModel);
        Get.offAllNamed(RouteHelper.initial);
        return userModel;
      }

      isLoading = false;
      update();
      error(
        context: Get.context!,
        title: 'login_failed'.tr,
        message: 'something_wrong'.tr,
      );
      return null;
    } on GoogleSignInException catch (e) {
      isLoading = false;
      update();
      if (e.code != GoogleSignInExceptionCode.canceled) {
        error(
          context: Get.context!,
          title: 'login_failed'.tr,
          message: e.description ?? 'something_wrong'.tr,
        );
        printError(e.toString());
      }
      return null;
    } catch (e) {
      isLoading = false;
      update();
      error(
        context: Get.context!,
        title: 'signUp_failed'.tr,
        message: e.toString(),
      );
      printError(e.toString());
      return null;
    }
  }

  Future<UserModel?> facebookLogin() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        // Once signed in, return the UserCredential
        final UserCredential userCredential = await firebaseAuth
            .signInWithCredential(facebookAuthCredential);

        if (userCredential.user != null) {
          User user = userCredential.user!;
          FirebaseAuth auth = FirebaseAuth.instance;
          UserModel userModel = UserModel(
            id: user.uid,
            email: user.email!,
            name:
                '${facebookAuthCredential.appleFullPersonName!.namePrefix!} '
                '${facebookAuthCredential.appleFullPersonName!.nameSuffix!}',
            bookmark: [],
            aiRecipes: [],
          );
          FirebaseUtil.users
              .where(ConstUtil.id, isEqualTo: auth.currentUser!.uid)
              .get()
              .then((value) {
                if (value.docs.isEmpty) {
                  FirebaseUtil.users
                      .doc(user.uid)
                      .set(userModel.toJson())
                      .catchError((e) {
                        throw e;
                      })
                      .then(
                        (value) => success(
                          context: Get.context!,
                          title: 'success'.tr,
                          message: 'signup_successful'.tr,
                        ),
                      );
                } else {
                  success(
                    context: Get.context!,
                    title: 'success'.tr,
                    message: 'login_successful'.tr,
                  );
                }
              });
          isLoading = false;
          update();
          StorageHelper.saveUser(userModel);
          Get.offAllNamed(RouteHelper.initial);
          return userModel;
        }
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
        title: 'login_failed'.tr,
        message: e.toString(),
      );
      printError(e);
      isLoading = false;
      update();
      return null;
    }
  }
}
