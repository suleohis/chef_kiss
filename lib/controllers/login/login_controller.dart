import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe_app/common/widgets/custom_snackbar.dart';
import 'package:recipe_app/util/app_export.dart';
import 'package:recipe_app/util/firebase_util.dart';

import '../../data/models/user_model.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool hidePassword = true;

  updateHidePassword() {
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

        DocumentSnapshot data = await FirebaseUtil.users.doc(user.uid).get();
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
        return userModel;
      }
      error(
        context: Get.context!,
        title: 'login_failed'.tr,
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
      isLoading = false;
      update();
      return null;
    }
  }

  Future<UserModel?> googleLogin() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      GoogleSignIn googleSignIn = GoogleSignIn();

      ///Sign in with google
      GoogleSignInAccount? googleUser = await googleSignIn.signIn().catchError(
        (e) => throw e,
      );

      if (googleUser == null) throw 'something_wrong';

      ///Get auth info
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication
          .catchError((e) => throw e);

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential.
      final userCredential = await firebaseAuth
          .signInWithCredential(credential)
          .catchError((e) => throw e);

      if (userCredential.user != null) {
        User user = userCredential.user!;
        FirebaseAuth auth = FirebaseAuth.instance;
        UserModel userModel = UserModel(
          id: user.uid,
          email: googleUser.email,
          name: googleUser.displayName!,
        );
        FirebaseUtil.users
            .where(ConstUtil.id, isEqualTo: auth.currentUser!.uid)
            .get()
            .then((value) {
              if (value.docs.isEmpty) {
                FirebaseUtil.users.doc(user.uid).set(userModel.to());
              }
            });
        isLoading = false;
        update();
        success(
          context: Get.context!,
          title: 'success'.tr,
          message: 'login_successful'.tr,
        );
        return userModel;
      }

      error(
        context: Get.context!,
        title: 'login_failed'.tr,
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
      isLoading = false;
      update();
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
          );
          FirebaseUtil.users
              .where(ConstUtil.id, isEqualTo: auth.currentUser!.uid)
              .get()
              .then((value) {
                if (value.docs.isEmpty) {
                  FirebaseUtil.users.doc(user.uid).set(userModel.to());
                }
              });
          isLoading = false;
          update();
          success(
            context: Get.context!,
            title: 'success'.tr,
            message: 'login_successful'.tr,
          );
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
      isLoading = false;
      update();
      return null;
    }
  }
}
