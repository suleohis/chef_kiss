import 'package:recipe_app/data/models/recipe_ai_model.dart';
import 'package:uuid/uuid.dart';

import '../../util/controller_export.dart';
import '../home/home_controller.dart';

class RecipeAiController extends GetxController {
  RecipeAIModel? selectedRecipe;

  // Nullable so they can be safely disposed and recreated on each edit
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  TextEditingController? ingredientsController;
  TextEditingController? instructionsController;
  TextEditingController? notesController;
  TextEditingController? cookingTimeController;
  TextEditingController? servingsController;

  String searchText = '';

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    titleController?.dispose();
    descriptionController?.dispose();
    ingredientsController?.dispose();
    instructionsController?.dispose();
    notesController?.dispose();
    cookingTimeController?.dispose();
    servingsController?.dispose();
  }

  void selectedRecipeFun(RecipeAIModel selected) {
    selectedRecipe = selected;
    assignValues();
    Get.toNamed(RouteHelper.editAIRecipe);
    update();
  }

  void onChangedText(String text) {
    searchText = text;
    update();
  }

  void assignValues() {
    // Dispose old controllers before creating new ones
    _disposeControllers();

    titleController = TextEditingController(text: selectedRecipe?.title);
    descriptionController = TextEditingController(
      text: selectedRecipe?.description,
    );
    ingredientsController = TextEditingController(
      text: selectedRecipe?.ingredients.join('\n'),
    );
    instructionsController = TextEditingController(
      text: selectedRecipe?.instructions.join('\n'),
    );
    notesController = TextEditingController(text: selectedRecipe?.notes);
    cookingTimeController = TextEditingController(
      text: selectedRecipe?.cookingTime,
    );
    servingsController = TextEditingController(text: selectedRecipe?.servings);
  }

  Iterable<RecipeAIModel> filteredRecipes(Iterable<RecipeAIModel> recipes) =>
      recipes
          .where(
            (recipe) =>
                recipe.title.toLowerCase().contains(
                      searchText.toLowerCase(),
                    ) ||
                recipe.description.toLowerCase().contains(
                      searchText.toLowerCase(),
                    ) ||
                recipe.tags.any(
                  (tag) => tag.toLowerCase().contains(
                        searchText.toLowerCase(),
                      ),
                ),
          )
          .toList()
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

  void onDone(RecipeAiController controller, BuildContext context,
      GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return;

    final recipe = RecipeAIModel(
      id: controller.selectedRecipe?.id ?? const Uuid().v4(),
      title: controller.titleController!.text.trim(),
      description: controller.descriptionController!.text.trim(),
      ingredients: controller.ingredientsController!.text
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      instructions: controller.instructionsController!.text
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      notes: controller.notesController!.text.trim(),
      cookingTime: controller.cookingTimeController!.text.trim(),
      servings: controller.servingsController!.text.trim(),
      tags: controller.selectedRecipe?.tags ?? [],
    );

    final UserModel? user = Get.find<HomeController>().user;

    if (user != null) {
      final int index = user.aiRecipes
          .indexWhere((element) => recipe.id == element['id']);
      if (index != -1) {
        user.aiRecipes[index] = recipe.toJson();
      } else {
        user.aiRecipes.add(recipe.toJson());
      }
      FirebaseRepo().updateUserRecipe(user);
      success(
        context: context,
        title: 'success'.tr,
        message: 'Recipe updated!',
      );
      Get.back();
    } else {
      error(
          context: context,
          title: 'error'.tr,
          message: 'something_wrong'.tr);
    }
  }

  void onDeleteFun(RecipeAIModel recipe, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: Text(
            'Are you sure you want to delete "${recipe.title}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              final UserModel? user = Get.find<HomeController>().user;
              if (user != null) {
                final int index = user.aiRecipes
                    .indexWhere((element) => recipe.id == element['id']);
                if (index != -1) user.aiRecipes.removeAt(index);
                FirebaseRepo().updateUserRecipe(user);
                success(
                  context: Get.context!,
                  title: 'Deleted',
                  message: '"${recipe.title}" has been removed.',
                );
              } else {
                error(
                  context: Get.context!,
                  title: 'error'.tr,
                  message: 'something_wrong'.tr,
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
