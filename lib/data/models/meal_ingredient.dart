class MealIngredient {
  final String ingredient;
  final String measure;

  // Constructor requires both ingredient and measure to be provided
  MealIngredient({required this.ingredient, required this.measure});

  // Optional: Method to convert to JSON (useful if you need to send this data back)
  Map<String, dynamic> toJson() {
    return {
      'ingredient': ingredient,
      'measure': measure,
    };
  }
}