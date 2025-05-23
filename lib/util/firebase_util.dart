import 'app_export.dart';

class FirebaseUtil {
  static FirebaseFirestore firebase = FirebaseFirestore.instance;

  static CollectionReference users = firebase.collection(ConstUtil.users);
}