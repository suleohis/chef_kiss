class FilteredMealItem {
  String? idMeal;
  String? strMeal;
  String? strMealThumb;

  FilteredMealItem({this.idMeal, this.strMeal, this.strMealThumb});

  // Factory constructor to create a FilteredMealItem object from a JSON map
  factory FilteredMealItem.fromJson(Map<String, dynamic> json) {
    return FilteredMealItem(
      idMeal: json['idMeal'] as String?,
      strMeal: json['strMeal'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
    );
  }

  // Method to convert a FilteredMealItem object to a JSON map (optional)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMeal'] = idMeal;
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    return data;
  }
}