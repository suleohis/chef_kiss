import 'package:recipe_app/util/app_export.dart';

class UserModel {
  String id;
  String name;
  String email;
  List bookmark;

  UserModel({required this.id, required this.email, required this.name, required this.bookmark});

  factory UserModel.from(Map<String,dynamic> user){
    return UserModel(
      id: user[ConstUtil.id],
      name: user[ConstUtil.name],
      email: user[ConstUtil.email],
      bookmark: user[ConstUtil.bookmark] ?? [],
    );
  }

  Map<String, dynamic> to(){
    return {
      ConstUtil.id: id,
      ConstUtil.name: name,
      ConstUtil.email: email,
      ConstUtil.bookmark: bookmark
    };
  }
}