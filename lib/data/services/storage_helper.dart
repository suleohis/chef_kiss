import 'dart:convert';

import 'package:recipe_app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static String userKey = 'userKey';

  /// Save User
  static saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(userKey, jsonEncode(user.to()));
  }

  /// Get User
  static Future<UserModel?> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? data = pref.getString(userKey);
    if (data == null) return null;
    return UserModel.from(jsonDecode(data)!);
  }

  static logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}