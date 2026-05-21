import 'package:uuid/uuid.dart';

class RecipeAIModel {
  RecipeAIModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    this.tags = const [],
    this.notes = '',
    this.cookingTime = '',
    this.servings = '',
  });

  RecipeAIModel.empty(String id)
      : this(
          id: id,
          title: '',
          description: '',
          ingredients: [],
          instructions: [],
          tags: [],
          notes: '',
          cookingTime: '',
          servings: '',
        );

  factory RecipeAIModel.fromJson(Map<String, dynamic> json) => RecipeAIModel(
        id: json['id'] ?? const Uuid().v4(),
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        ingredients: List<String>.from(json['ingredients'] ?? []),
        instructions: List<String>.from(json['instructions'] ?? []),
        tags: json['tags'] == null ? [] : List<String>.from(json['tags']),
        notes: json['notes'] ?? '',
        cookingTime: json['cookingTime'] ?? '',
        servings: json['servings'] ?? '',
      );

  final String id;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final List<String> tags;
  final String notes;
  final String cookingTime;
  final String servings;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'ingredients': ingredients,
        'instructions': instructions,
        'tags': tags,
        'notes': notes,
        'cookingTime': cookingTime,
        'servings': servings,
      };

  static List<RecipeAIModel> loadFrom(List jsonList) =>
      [for (final json in jsonList) RecipeAIModel.fromJson(json as Map<String, dynamic>)];

  @override
  String toString() => [
        '# $title',
        if (description.isNotEmpty) description,
        if (cookingTime.isNotEmpty) '⏱ Cooking Time: $cookingTime',
        if (servings.isNotEmpty) '🍽 Servings: $servings',
        '',
        '## Ingredients',
        ...ingredients.map((i) => '• $i'),
        '',
        '## Instructions',
        ...instructions.asMap().entries.map((e) => '${e.key + 1}. ${e.value}'),
        if (tags.isNotEmpty) '\nTags: ${tags.join(', ')}',
      ].join('\n');
}
