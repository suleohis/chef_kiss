class IngredientListItem {
  String? idIngredient;
  String? strIngredient;
  String? strDescription;
  String? strType;

  IngredientListItem({
    this.idIngredient,
    this.strIngredient,
    this.strDescription,
    this.strType,
  });

  factory IngredientListItem.fromJson(Map<String, dynamic> json) {
    return IngredientListItem(
      idIngredient: json['idIngredient'] as String?,
      strIngredient: json['strIngredient'] as String?,
      strDescription: json['strDescription'] as String?,
      strType: json['strType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idIngredient'] = idIngredient;
    data['strIngredient'] = strIngredient;
    data['strDescription'] = strDescription;
    data['strType'] = strType;
    return data;
  }
}