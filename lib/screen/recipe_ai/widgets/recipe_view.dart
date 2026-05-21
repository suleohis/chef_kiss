import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/models/recipe_ai_model.dart';
import 'recipe_content_view.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({
    required this.recipe,
    required this.expanded,
    required this.onExpansionChanged,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final RecipeAIModel recipe;
  final bool expanded;
  final ValueChanged<bool>? onExpansionChanged;
  final Function() onEdit;
  final Function() onDelete;

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: recipe.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recipe copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          children: [
            ExpansionTile(
              title: Text(recipe.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recipe.description.isNotEmpty)
                    Text(recipe.description,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  if (recipe.cookingTime.isNotEmpty ||
                      recipe.servings.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Wrap(
                        spacing: 12,
                        children: [
                          if (recipe.cookingTime.isNotEmpty)
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              Icon(Icons.timer_outlined,
                                  size: 13,
                                  color: Colors.grey.shade600),
                              const SizedBox(width: 3),
                              Text(recipe.cookingTime,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600)),
                            ]),
                          if (recipe.servings.isNotEmpty)
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              Icon(Icons.people_outline,
                                  size: 13,
                                  color: Colors.grey.shade600),
                              const SizedBox(width: 3),
                              Text(recipe.servings,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600)),
                            ]),
                        ],
                      ),
                    ),
                  if (recipe.tags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Wrap(
                        spacing: 4,
                        children: [
                          for (final tag in recipe.tags)
                            Chip(
                              label: Text(tag,
                                  style: const TextStyle(fontSize: 11)),
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                        ],
                      ),
                    ),
                ],
              ),
              initiallyExpanded: expanded,
              onExpansionChanged: onExpansionChanged,
              children: [
                RecipeContentView(recipe: recipe),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OverflowBar(
                    spacing: 8,
                    alignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        tooltip: 'Copy to clipboard',
                        icon: const Icon(Icons.copy_outlined),
                        onPressed: () => _copyToClipboard(context),
                      ),
                      ElevatedButton(
                        onPressed: onDelete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Delete'),
                      ),
                      OutlinedButton(
                          onPressed: onEdit, child: const Text('Edit')),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      );
}
