import 'package:recipe_app/util/app_export.dart';

class UserModel {
  String id;
  String name;
  String email;
  List bookmark;
  List aiRecipes;

  UserModel({required this.id, required this.email, required this.name, required this.bookmark, required this.aiRecipes});

  factory UserModel.from(Map<String,dynamic> user){
    return UserModel(
      id: user[ConstUtil.id],
      name: user[ConstUtil.name],
      email: user[ConstUtil.email],
      bookmark: user[ConstUtil.bookmark] ?? [],
      aiRecipes: user[ConstUtil.aiRecipes] ?? [],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      ConstUtil.id: id,
      ConstUtil.name: name,
      ConstUtil.email: email,
      ConstUtil.bookmark: bookmark,
      ConstUtil.aiRecipes: aiRecipes
    };
  }
}