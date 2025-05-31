import '../list_items/category_list_item.dart';

class CategoryListResponse {
  List<CategoryListItem>? categories; // Renamed to 'categories' for clarity in the model

  CategoryListResponse({this.categories});

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) {
    return CategoryListResponse(
      categories: json['meals'] != null // API uses 'meals' key for category list
          ? (json['meals'] as List)
          .map((i) => CategoryListItem.fromJson(i as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['meals'] = categories!.map((v) => v.toJson()).toList(); // Convert back to 'meals' for API
    }
    return data;
  }
}