import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/common/widgets/custom_snackbar.dart';
import 'package:recipe_app/util/firebase_util.dart';

import '../../data/models/user_model.dart';

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

  updateAccept(){
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
          ).catchError((e) {throw e;});

      if (credential.user != null) {
        User user = credential.user!;
        UserModel userModel = UserModel(
          id: user.uid,
          email: emailController.text,
          name: nameController.text,
        );
        await FirebaseUtil.users.doc(user.uid).set(userModel.to());

        isLoading = false;
        update();
        success(
          context: Get.context!,
          title: 'success'.tr,
          message: 'signup_successful'.tr,
        );
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
      error(context:  Get.context!, title: 'signUp_failed'.tr, message: e.toString());
      isLoading = false;
      update();
      return null;
    }
  }
}
