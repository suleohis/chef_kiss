import 'meal_ingredient.dart';

class Meal {
  String? idMeal;
  String? strMeal;
  String? strDrinkAlternate;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  String? strSource;
  String? dateModified;

  // NEW FIELD: A list of MealIngredient objects
  List<MealIngredient>? mealIngredients;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    this.dateModified,
    this.mealIngredients, // Add to constructor
  });

  // Factory constructor to create a Meal object from a JSON map
  factory Meal.fromJson(Map<String, dynamic> json) {
    List<MealIngredient> parsedMealIngredients = [];

    // Loop through strIngredient1 to strIngredient20 and strMeasure1 to strMeasure20
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'] as String?;
      String? measure = json['strMeasure$i'] as String?;

      // If the ingredient string is null or empty after trimming, skip this pair.
      // This ensures we only create MealIngredient objects for actual ingredients.
      if (ingredient == null || ingredient.trim().isEmpty) {
        continue; // Skip to the next iteration
      }

      // Create MealIngredient. If measure is null, default to an empty string.
      parsedMealIngredients.add(MealIngredient(
        ingredient: ingredient.trim(),
        measure: (measure ?? '').trim(), // Ensure measure is not null
      ));
    }

    return Meal(
      idMeal: json['idMeal'] as String?,
      strMeal: json['strMeal'] as String?,
      strDrinkAlternate: json['strDrinkAlternate'] as String?,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String?,
      strSource: json['strSource'] as String?,
      dateModified: json['dateModified'] as String?,
      // Assign the parsed list of MealIngredient objects
      mealIngredients: parsedMealIngredients.isEmpty ? null : parsedMealIngredients,
    );
  }

  // Method to convert a Meal object to a JSON map (optional, but good for serialization)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMeal'] = idMeal;
    data['strMeal'] = strMeal;
    data['strDrinkAlternate'] = strDrinkAlternate;
    data['strCategory'] = strCategory;
    data['strArea'] = strArea;
    data['strInstructions'] = strInstructions;
    data['strMealThumb'] = strMealThumb;
    data['strTags'] = strTags;
    data['strYoutube'] = strYoutube;
    data['strSource'] = strSource;
    data['dateModified'] = dateModified;

    // Convert List<MealIngredient> back to strIngredientX/strMeasureX for JSON
    if (mealIngredients != null) {
      for (int i = 0; i < mealIngredients!.length && i < 20; i++) {
        data['strIngredient${i + 1}'] = mealIngredients![i].ingredient;
        data['strMeasure${i + 1}'] = mealIngredients![i].measure;
      }
    }
    // Fill remaining strIngredientX/strMeasureX with null if lists are shorter than 20
    // This is important if the API expects all 20 fields, even if empty.
    for (int i = (mealIngredients?.length ?? 0); i < 20; i++) {
      data['strIngredient${i + 1}'] = null;
      data['strMeasure${i + 1}'] = null;
    }

    return data;
  }
}