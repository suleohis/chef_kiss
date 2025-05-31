import 'filtered_meal.dart';

class FilteredMealResponse {
  List<FilteredMealItem>? meals; // Keeping the 'meals' key to match API response

  FilteredMealResponse({this.meals});

  factory FilteredMealResponse.fromJson(Map<String, dynamic> json) {
    // The API might return null if no meals are found for the filter,
    // so we handle that case.
    return FilteredMealResponse(
      meals: json['meals'] != null
          ? (json['meals'] as List)
          .map((i) => FilteredMealItem.fromJson(i as Map<String, dynamic>))
          .toList()
          : null, // If 'meals' is null, return null or an empty list
    );
  }

  // Method to convert a FilteredMealResponse object to a JSON map (optional)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}