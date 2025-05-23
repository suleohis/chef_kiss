import 'package:recipe_app/util/app_export.dart';

class UserModel {
  String id;
  String name;
  String email;

  UserModel({required this.id, required this.email, required this.name});

  factory UserModel.from(Map<String,dynamic> user){
    return UserModel(
      id: user[ConstUtil.id],
      name: user[ConstUtil.name],
      email: user[ConstUtil.email],
    );
  }

  Map<String, dynamic> to(){
    return {
      ConstUtil.id: id,
      ConstUtil.name: name,
      ConstUtil.email: email
    };
  }
}