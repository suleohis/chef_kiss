import 'package:recipe_app/data/models/category_response.dart';
import 'package:recipe_app/util/controller_export.dart';

import '../../data/models/category.dart';
import '../home/home_controller.dart';

class CategoriesController extends GetxController {
  MealRepo mealRepo = MealRepo();
  List<Category> categories = [];
  bool isLoadingCategory = false;
  bool isLoadingMeal = false;
  Category? selectedCategory;
  List<FilteredMealItem> meals = [];

  @override
  void onInit() {
    super.onInit();
    getCategoriesData();
  }

  Future<void> onRefresh() async {
    getCategoriesData();
    Get.find<HomeController>().getUser();
  }

  onSelectedCategory(int index) {
    selectedCategory = categories[index];
    Get.toNamed(RouteHelper.categoriesMeal);
    getMealsData();
    update();
  }

  /// Get Categories
  getCategoriesData() async {
    try {
      if (categories.isNotEmpty) {
        return;
      }

      isLoadingCategory = true;
      update();

      ResponseModel responseModel = await mealRepo.getCategories();
      if (responseModel.statusCode == 200) {
        CategoryResponse response = CategoryResponse.fromJson(
          responseModel.responseJson,
        );

        categories = response.categories ?? [];

        printInfo(categories);
        isLoadingCategory = false;
        update();
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      isLoadingCategory = false;
      update();
      printError(e.toString());
    }
  }

  /// Get Meals Data
  getMealsData() async {
    try {
      isLoadingMeal = true;
      update();
      late ResponseModel responseModel;
      responseModel = await mealRepo.getFilterByCategory(
        selectedCategory?.strCategory ?? '',
      );

      if (responseModel.statusCode == 200) {
        FilteredMealResponse response = FilteredMealResponse.fromJson(
          responseModel.responseJson,
        );

        meals = response.meals ?? [];
        isLoadingMeal = false;
        update();
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      printError(e.toString());
      isLoadingMeal = false;
      update();
    }
  }
}
