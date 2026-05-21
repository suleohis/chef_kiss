import 'dart:convert';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../data/models/recipe_ai_model.dart';
import '../../../data/repositories/firebase_repo.dart';
import '../../../util/app_export.dart';
import 'recipe_content_view.dart';

class RecipeResponseView extends StatefulWidget {
  final String response;

  const RecipeResponseView(this.response, {super.key});

  @override
  State<RecipeResponseView> createState() => _RecipeResponseViewState();
}

class _RecipeResponseViewState extends State<RecipeResponseView> {
  final Set<int> _addedIndices = {};

  /// Returns true only when the response looks like it could be complete JSON.
  /// Avoids trying to parse mid-stream chunks or error strings.
  bool get _looksLikeCompleteJson {
    final s = widget.response.trim();
    return s.startsWith('{') && s.endsWith('}');
  }

  void _addRecipe(int index, RecipeAIModel recipe) {
    final user = Get.find<HomeController>().user;
    if (user == null) return;

    final alreadySaved = user.aiRecipes.any(
      (r) => r['id'] == recipe.id || r['title'] == recipe.title,
    );

    if (alreadySaved || _addedIndices.contains(index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This recipe is already in your list.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    user.aiRecipes.add(recipe.toJson());
    FirebaseRepo().updateUserRecipe(user);
    setState(() => _addedIndices.add(index));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${recipe.title}" added to My Recipes!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // While the response is still streaming (not yet valid complete JSON),
    // show a subtle typing indicator so the UI isn't blank or broken.
    if (!_looksLikeCompleteJson) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text('Thinking…', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    final children = <Widget>[];
    String? finalText;
    int recipeIndex = 0;

    try {
      final map = jsonDecode(widget.response) as Map<String, dynamic>;
      final recipesRaw = map['recipes'];
      final recipesWithText =
          recipesRaw is List ? recipesRaw : <dynamic>[];
      finalText = map['text'] as String?;

      for (final recipeWithText in recipesWithText) {
        if (recipeWithText is! Map<String, dynamic>) continue;
        final currentIndex = recipeIndex++;

        final text = recipeWithText['text'] as String?;
        if (text != null && text.isNotEmpty) {
          children.add(MarkdownBody(data: text));
        }

        final recipeJson = recipeWithText['recipe'];
        if (recipeJson is! Map<String, dynamic>) continue;

        final recipe = RecipeAIModel.fromJson(recipeJson);
        if (recipe.title.isEmpty) continue;

        children.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (recipe.description.isNotEmpty)
                Text(recipe.description).paddingOnly(top: 4),
              if (recipe.cookingTime.isNotEmpty || recipe.servings.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Wrap(
                    spacing: 16,
                    children: [
                      if (recipe.cookingTime.isNotEmpty)
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.timer_outlined, size: 16),
                          const SizedBox(width: 4),
                          Text(recipe.cookingTime),
                        ]),
                      if (recipe.servings.isNotEmpty)
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.people_outline, size: 16),
                          const SizedBox(width: 4),
                          Text(recipe.servings),
                        ]),
                    ],
                  ),
                ),
              RecipeContentView(recipe: recipe),
            ],
          ),
        );

        final isAdded = _addedIndices.contains(currentIndex);
        children.add(
          OutlinedButton.icon(
            onPressed: isAdded ? null : () => _addRecipe(currentIndex, recipe),
            icon: Icon(isAdded ? Icons.check : Icons.add),
            label: Text(isAdded ? 'Added' : 'Add to My Recipes'),
          ),
        );
      }
    } catch (e) {
      // JSON parsing failed on the final response — log and fall through
      // to the plain-text fallback below.
      debugPrint('RecipeResponseView parse error: $e');
    }

    // For non-recipe answers (tips, advice, etc.) or parse failures,
    // show whatever text the model returned as plain markdown.
    if (children.isEmpty) {
      final displayText = finalText?.isNotEmpty == true
          ? finalText!
          : widget.response.trim();

      if (displayText.isNotEmpty) {
        children.add(MarkdownBody(data: displayText));
      }
    } else if (finalText != null && finalText.isNotEmpty) {
      children.add(MarkdownBody(data: finalText));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          children[i],
          if (i < children.length - 1) const SizedBox(height: 16),
        ],
      ],
    );
  }
}
