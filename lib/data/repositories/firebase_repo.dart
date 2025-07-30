import '../../util/controller_export.dart';

class FirebaseRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Get User Info
  Future<UserModel?> getUser() async {
    try {
      DocumentSnapshot doc =
          await FirebaseUtil.users.doc(auth.currentUser!.uid).get();
      if (doc.exists) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        StorageHelper.saveUser(UserModel.from(map));
        return UserModel.from(map);
      }
      return StorageHelper.getUser();
    } catch (e) {
      printError(e.toString());
      return StorageHelper.getUser();
    }
  }

  /// Save User Info
  Future<bool> saveUser(UserModel user) async {
    try {
      return await FirebaseUtil.users
          .doc(auth.currentUser!.uid)
          .update(user.toJson())
          .then((value) {
        StorageHelper.saveUser(user);
        return true;
      })
          .catchError((error) => throw error);
    } catch (e) {
      printError(e.toString());
      return false;
    }
  }

  /// Delete User
  Future<bool> deleteUser() async {
    try {
      return await FirebaseUtil.users
          .doc(auth.currentUser!.uid)
          .delete()
          .then((value) {
        return true;
      })
          .catchError((error) => throw error);
    } catch (e) {
      error(
        context: Get.context!,
        title: 'error'.tr,
        message: e.toString(),
      );
      return false;
    }
  }
  
  /// Update User AI Recipes
  Future<bool> updateUserRecipe(UserModel user) async {
    try {
      return await FirebaseUtil.users
          .doc(auth.currentUser!.uid)
          .update(user.toJson())
          .then((value) {
        return true;
      })
          .catchError((error) => throw error);
    } catch (e) {
      error(
        context: Get.context!,
        title: 'error'.tr,
        message: e.toString(),
      );
      return false;
    }
  }
}
