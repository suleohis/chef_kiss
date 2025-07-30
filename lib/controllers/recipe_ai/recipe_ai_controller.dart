import 'package:recipe_app/data/models/recipe_ai_model.dart';
import 'package:uuid/uuid.dart';

import '../../util/controller_export.dart';
import '../home/home_controller.dart';

class RecipeAiController extends GetxController {
  RecipeAIModel? selectedRecipe;



  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController ingredientsController;
  late final TextEditingController instructionsController;
  String searchText = '';

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    ingredientsController.dispose();
    instructionsController.dispose();
    super.dispose();
  }
  
  void selectedRecipeFun(RecipeAIModel selected) {
    selectedRecipe = selected;
    assignValues();
    Get.toNamed(RouteHelper.editAIRecipe);
    update();
  }

  void onChangedText (String text) {
    searchText = text;
    update();
  }

  void assignValues() {

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

  void onDone(RecipeAiController controller, context, formKey ) {
    if (!formKey.currentState!.validate()) return;

    final recipe = RecipeAIModel(
      id: controller.selectedRecipe?.id ?? Uuid().v4(),
      title: controller.titleController.text,
      description: controller.descriptionController.text,
      ingredients: controller.ingredientsController.text.split('\n'),
      instructions: controller.instructionsController.text.split('\n'),
    );
    UserModel? user = Get.find<HomeController>().user;

    if (user != null) {
      int index = user.aiRecipes.indexWhere((element)=> recipe.id == element['id']);
      user.aiRecipes[index] = recipe.toJson();
      FirebaseRepo().updateUserRecipe(user);
    } else {
      error(context: context, title: 'error'.tr, message: 'something_wrong'.tr);
    }

    Get.toNamed(RouteHelper.initial);
  }

  void onDeleteFun(RecipeAIModel recipe, context ) {

    UserModel? user = Get.find<HomeController>().user;

    if (user != null) {
      int index = user.aiRecipes.indexWhere((element)=> recipe.id == element['id']);
      user.aiRecipes.removeAt(index);
      FirebaseRepo().updateUserRecipe(user);
    } else {
      error(context: context, title: 'error'.tr, message: 'something_wrong'.tr);
    }

    Get.toNamed(RouteHelper.initial);
  }
}
