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
  List<String>? ingredients; // Combined list of ingredients
  List<String>? measures;    // Combined list of measures

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
    this.ingredients,
    this.measures,
  });

  // Factory constructor to create a Meal object from a JSON map
  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> parsedIngredients = [];
    List<String> parsedMeasures = [];

    // Loop through strIngredient1 to strIngredient20 and strMeasure1 to strMeasure20
    // and add non-empty/non-null values to the lists
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'] as String?;
      String? measure = json['strMeasure$i'] as String?;

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        parsedIngredients.add(ingredient.trim());
      }
      if (measure != null && measure.trim().isNotEmpty) {
        parsedMeasures.add(measure.trim());
      }
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
      ingredients: parsedIngredients.isEmpty ? null : parsedIngredients, // Set to null if empty
      measures: parsedMeasures.isEmpty ? null : parsedMeasures,       // Set to null if empty
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

    // Convert combined lists back to strIngredientX/strMeasureX for JSON
    if (ingredients != null) {
      for (int i = 0; i < ingredients!.length && i < 20; i++) {
        data['strIngredient${i + 1}'] = ingredients![i];
      }
    }
    if (measures != null) {
      for (int i = 0; i < measures!.length && i < 20; i++) {
        data['strMeasure${i + 1}'] = measures![i];
      }
    }
    // Fill remaining strIngredientX/strMeasureX with null if lists are shorter than 20
    for (int i = (ingredients?.length ?? 0); i < 20; i++) {
      data['strIngredient${i + 1}'] = null;
    }
    for (int i = (measures?.length ?? 0); i < 20; i++) {
      data['strMeasure${i + 1}'] = null;
    }

    return data;
  }
}