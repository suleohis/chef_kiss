import '../list_items/ingredient_list_item.dart';

class IngredientListResponse {
  List<IngredientListItem>? ingredients; // Renamed to 'ingredients' for clarity in the model

  IngredientListResponse({this.ingredients});

  factory IngredientListResponse.fromJson(Map<String, dynamic> json) {
    return IngredientListResponse(
      ingredients: json['meals'] != null // API uses 'meals' key for ingredient list
          ? (json['meals'] as List)
          .map((i) => IngredientListItem.fromJson(i as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ingredients != null) {
      data['meals'] = ingredients!.map((v) => v.toJson()).toList(); // Convert back to 'meals' for API
    }
    return data;
  }
}