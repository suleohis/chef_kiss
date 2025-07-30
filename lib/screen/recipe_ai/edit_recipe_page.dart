import 'package:recipe_app/controllers/recipe_ai/recipe_ai_controller.dart';
import '../../util/app_export.dart';

class EditRecipePage extends StatelessWidget {
  EditRecipePage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => GetBuilder<RecipeAiController>(
    builder: (controller) {
      return Scaffold(
        appBar: AppBar(title: Text('Edit Recipe')),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter a name for your recipe...',
                  ),
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? 'Recipe title is requires'
                              : null,
                ),
                TextField(
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'In a few words, describe your recipe...',
                  ),
                  maxLines: null,
                ),
                TextField(
                  controller: controller.ingredientsController,
                  decoration: const InputDecoration(
                    labelText: 'Ingredients🍎 (one per line)',
                    hintText: 'e.g., 2 cups flour\n1 tsp salt\n1 cup sugar',
                  ),
                  maxLines: null,
                ),
                TextField(
                  controller: controller.instructionsController,
                  decoration: const InputDecoration(
                    labelText: 'Instructions🥧 (one per line)',
                    hintText: 'e.g., Mix ingredients\nBake for 30 minutes',
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                OverflowBar(
                  spacing: 16,
                  children: [
                    OutlinedButton(
                      onPressed:
                          () =>
                              controller.onDone(controller, context, _formKey),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
