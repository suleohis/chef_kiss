import 'package:get/get.dart';
import 'package:recipe_app/controllers/home/home_controller.dart';
import 'package:recipe_app/controllers/recipe_detail/recipe_detail_controller.dart';

class RecipeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RecipeDetailController>(
      RecipeDetailController(
        mealId:
            Get.find<HomeController>().meal == null
                ? Get.arguments['mealId']
                : '',
      ),
    );
  }
}
