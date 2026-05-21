import 'package:recipe_app/controllers/recipe_ai/recipe_ai_controller.dart';
import '../../util/app_export.dart';

class EditRecipePage extends StatelessWidget {
  EditRecipePage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => GetBuilder<RecipeAiController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(title: const Text('Edit Recipe')),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    TextFormField(
                      controller: controller.titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title *',
                        hintText: 'Enter a name for your recipe…',
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Recipe title is required'
                              : null,
                    ),
                    const SizedBox(height: 12),

                    // Description
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'In a few words, describe your recipe…',
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 12),

                    // Cooking time & servings side by side
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.cookingTimeController,
                            decoration: const InputDecoration(
                              labelText: '⏱ Cooking Time',
                              hintText: 'e.g. 30 minutes',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: controller.servingsController,
                            decoration: const InputDecoration(
                              labelText: '🍽 Servings',
                              hintText: 'e.g. 4 servings',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Ingredients
                    TextFormField(
                      controller: controller.ingredientsController,
                      decoration: const InputDecoration(
                        labelText: 'Ingredients 🍎 (one per line) *',
                        hintText: 'e.g.\n2 cups flour\n1 tsp salt\n1 cup sugar',
                        alignLabelWithHint: true,
                      ),
                      maxLines: null,
                      minLines: 3,
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Please add at least one ingredient'
                              : null,
                    ),
                    const SizedBox(height: 12),

                    // Instructions
                    TextFormField(
                      controller: controller.instructionsController,
                      decoration: const InputDecoration(
                        labelText: 'Instructions 🥧 (one per line) *',
                        hintText:
                            'e.g.\nMix the dry ingredients.\nBake for 30 minutes.',
                        alignLabelWithHint: true,
                      ),
                      maxLines: null,
                      minLines: 3,
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Please add at least one instruction'
                              : null,
                    ),
                    const SizedBox(height: 12),

                    // Notes
                    TextFormField(
                      controller: controller.notesController,
                      decoration: const InputDecoration(
                        labelText: '📝 Notes',
                        hintText: 'Any extra tips or personal notes…',
                        alignLabelWithHint: true,
                      ),
                      maxLines: null,
                      minLines: 2,
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () =>
                            controller.onDone(controller, context, _formKey),
                        child: const Text('Save Recipe'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
