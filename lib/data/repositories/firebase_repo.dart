import '../../util/controller_export.dart';

class FirebaseRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel?> getUser() async {
    try {
      DocumentSnapshot doc = await FirebaseUtil.users.doc(auth.currentUser!.uid).get();
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
}