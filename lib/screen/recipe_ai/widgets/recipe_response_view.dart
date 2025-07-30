import 'dart:convert';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../data/models/recipe_ai_model.dart';
import '../../../data/repositories/firebase_repo.dart';
import '../../../util/app_export.dart';
import 'recipe_content_view.dart';

class RecipeResponseView extends StatelessWidget {
  final String response;

  const RecipeResponseView(this.response, {super.key});

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    String? finalText;

    // created with the response from the LLM as the response streams in, so
    // many not be a complete response yet
    try {
      final map = jsonDecode(response);
      final recipesWithText = map['recipes'] as List<dynamic>;
      finalText = map['text'] as String?;

      for (final recipeWithText in recipesWithText) {
        // extract the text before the recipe
        final text = recipeWithText['text'] as String?;
        if (text != null && text.isNotEmpty) {
          children.add(MarkdownBody(data: text));
        }

        // extract the recipe
        final json = recipeWithText['recipe'] as Map<String, dynamic>;
        final recipe = RecipeAIModel.fromJson(json);
        children.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recipe.title, style: Theme.of(context).textTheme.titleLarge),
              Text(recipe.description),
              RecipeContentView(recipe: recipe),
            ],
          ),
        );

        // add a button to add the recipe to the list
        children.add(
          OutlinedButton(
            onPressed: () {
              if (Get.find<HomeController>().user?.aiRecipes == null) {
                Get.find<HomeController>().user?.aiRecipes = [];
              }
              Get.find<HomeController>().user?.aiRecipes.add(recipe.toJson());
              FirebaseRepo().updateUserRecipe(Get.find<HomeController>().user!);
            },
            child: const Text('Add Recipe'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error parsing response: $e');
    }

    if (children.isEmpty) {
      try {
        final map = jsonDecode(response);
        finalText = map['text'] as String?;
      } catch (e) {
        debugPrint('Error parsing response: $e');
        finalText = response;
      }
    }

    // add the remaining text
    if (finalText != null && finalText.isNotEmpty) {
      children.add(MarkdownBody(data: finalText));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: children,
    );
  }
}
