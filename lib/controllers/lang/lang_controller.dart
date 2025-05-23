import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LangModel {
  String name;
  String value;
  LangModel({required this.name, required this.value});
}


class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
  };

  Map<String, String> en = {};

  Future<void> load() async {
    en = Map<String, String>.from(
        json.decode(await rootBundle.loadString('assets/translations/en.json')));
  }

  Future<LangModel> getLang() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? name = preferences.getString(AppConst.name);
    // String? value = preferences.getString(AppConst.value);
    LangModel langModel =
    LangModel(name: 'English', value: 'en');
    return langModel;
  }
}
