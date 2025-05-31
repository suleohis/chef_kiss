import 'category.dart';

class CategoryResponse {
  List<Category>? categories;

  CategoryResponse({this.categories});

  // Factory constructor to create a CategoryResponse object from a JSON map
  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      categories: json['categories'] != null
          ? (json['categories'] as List)
          .map((i) => Category.fromJson(i as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  // Method to convert a CategoryResponse object to a JSON map (optional)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}