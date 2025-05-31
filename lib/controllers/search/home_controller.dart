import '../../util/controller_export.dart';

class HomeController extends GetxController {
  FirebaseRepo firebaseRepo = FirebaseRepo();
  UserModel? user;
  int catIndex = 0;
  CategoryListItem? selectedCategory;
  List<CategoryListItem> categories = [];
  List<FilteredMealItem> meals = [];
  MealRepo mealRepo = MealRepo();
  bool isLoadingCategory = false;
  bool isLoadingMeal = false;

  @override
  void onInit() {
    super.onInit();
    getCategoriesData();
    getUser();
  }

  onRefresh() {
    getCategoriesData();
    getUser();
  }

  selectCategory(index) {
    if (selectedCategory?.strCategory != categories[index].strCategory) {
      catIndex = index;
      selectedCategory = categories[index];
      meals = [];
      getMealsData();
      update();
    }
  }

  /// Get User
  getUser() async {
    user = await firebaseRepo.getUser();
    update();
  }

  /// Get Categories
  getCategoriesData() async {
    try {
      isLoadingCategory = true;
      update();
      
      ResponseModel responseModel = await mealRepo.getFilter('c=list');
      if (responseModel.statusCode == 200) {
        CategoryListResponse response = CategoryListResponse.fromJson(responseModel.responseJson);

        categories = response.categories ?? [];
        
        if (selectedCategory == null) {
          selectedCategory = categories.first;
          getMealsData();
          update();
        }

        isLoadingCategory = false;
        update();
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      isLoadingCategory = false;
      update();
    }
  }

  /// Get Meals
  getMealsData() async {
    try {
      isLoadingMeal = true;
      update();
      ResponseModel responseModel = await mealRepo.getFilterByCategory(selectedCategory?.strCategory ?? '');
      if (responseModel.statusCode == 200) {
        FilteredMealResponse response = FilteredMealResponse.fromJson(responseModel.responseJson);

        meals = response.meals ?? [];
        isLoadingMeal = false;
        update();
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      isLoadingMeal = false;
      update();
    }
  }
}