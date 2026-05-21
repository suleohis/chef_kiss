import 'package:flutter/material.dart';

import '../../../data/models/recipe_ai_model.dart';

class RecipeContentView extends StatelessWidget {
  const RecipeContentView({super.key, required this.recipe});

  final RecipeAIModel recipe;
  static const mobileBreakpoint = 600;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cooking time & servings row
            if (recipe.cookingTime.isNotEmpty || recipe.servings.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 4,
                  children: [
                    if (recipe.cookingTime.isNotEmpty)
                      _InfoChip(
                        icon: Icons.timer_outlined,
                        label: recipe.cookingTime,
                      ),
                    if (recipe.servings.isNotEmpty)
                      _InfoChip(
                        icon: Icons.people_outline,
                        label: recipe.servings,
                      ),
                  ],
                ),
              ),

            // Ingredients & instructions
            LayoutBuilder(
              builder: (context, constraints) =>
                  constraints.maxWidth < mobileBreakpoint
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _RecipeIngredientsView(recipe),
                            const SizedBox(height: 16),
                            _RecipeInstructionsView(recipe),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _RecipeIngredientsView(recipe)),
                            const SizedBox(width: 16),
                            Expanded(child: _RecipeInstructionsView(recipe)),
                          ],
                        ),
            ),

            // Tags
            if (recipe.tags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    for (final tag in recipe.tags)
                      Chip(
                        label: Text(tag, style: const TextStyle(fontSize: 12)),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ),
          ],
        ),
      );
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(label,
              style:
                  TextStyle(fontSize: 13, color: Colors.grey.shade700)),
        ],
      );
}

class _RecipeIngredientsView extends StatelessWidget {
  const _RecipeIngredientsView(this.recipe);
  final RecipeAIModel recipe;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ingredients 🍎',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          ...[for (final ingredient in recipe.ingredients) Text('• $ingredient')],
        ],
      );
}

class _RecipeInstructionsView extends StatelessWidget {
  const _RecipeInstructionsView(this.recipe);
  final RecipeAIModel recipe;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Instructions 🥧',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          ...[
            for (final entry in recipe.instructions.asMap().entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('${entry.key + 1}. ${entry.value}'),
              ),
          ],
        ],
      );
}
