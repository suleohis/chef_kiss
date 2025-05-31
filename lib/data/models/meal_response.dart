 import 'meal.dart';

class MealResponse {
  List<Meal>? meals;

  MealResponse({this.meals});

  // Factory constructor to create a MealResponse object from a JSON map
  factory MealResponse.fromJson(Map<String, dynamic> json) {
    return MealResponse(
      meals: json['meals'] != null
          ? (json['meals'] as List) // Cast the 'meals' value to a List
          .map((i) => Meal.fromJson(i as Map<String, dynamic>)) // Map each item to a Meal object
          .toList() // Convert the iterable to a List
          : null, // If 'meals' is null, set the meals list to null
    );
  }

  // Method to convert a MealResponse object to a JSON map (optional, but good for serialization)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}