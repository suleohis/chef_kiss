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
  RxBool isLoadingRandom = false.obs;
  Meal? meal;

  @override
  void onInit() {
    super.onInit();
    getCategoriesData();
    getUser();
  }

  Future<void> onRefresh() async {
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
        CategoryListResponse response = CategoryListResponse.fromJson(
          responseModel.responseJson,
        );

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
      ResponseModel responseModel = await mealRepo.getFilterByCategory(
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
      isLoadingMeal = false;
      update();
    }
  }

  /// Random Food Lookup
  randomFoodLookup() async {
    try {
      isLoadingRandom = true.obs;
      update();
      ResponseModel responseModel = await mealRepo.getRandomSingleMeal();
      if (responseModel.statusCode == 200) {
        MealResponse response = MealResponse.fromJson(
          responseModel.responseJson,
        );

        meal = response.meals?.first;
        if (meal != null) {
          Get.toNamed(RouteHelper.recipeDetail);
        } else {
          error(
            context: Get.context!,
            title: 'error'.tr,
            message: 'something_wrong'.tr,
          );
        }
        isLoadingRandom = false.obs;
        update();
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      isLoadingRandom = false.obs;
      update();
    }
  }

  /// Logout
  logout() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signOut()
        .then((value) {
          StorageHelper.logout();
          Get.offAllNamed(RouteHelper.login);
          success(
            context: Get.context!,
            title: 'success'.tr,
            message: 'logout_successful'.tr,
          );
        })
        .catchError((error) {
          printError(error.toString());
          error(
            context: Get.context!,
            title: 'error'.tr,
            message: 'something_wrong'.tr,
          );
        });
  }
}
