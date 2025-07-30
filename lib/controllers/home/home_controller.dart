import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:recipe_app/util/app_export.dart';

import '../../util/controller_export.dart';

class HomeController extends GetxController {
  FirebaseRepo firebaseRepo = FirebaseRepo();
  UserModel? user;
  int catIndex = 0;
  CategoryListItem? selectedCategory;
  List<CategoryListItem> categories = [];
  List<FilteredMealItem> meals = [];
  MealRepo mealRepo = MealRepo();
  bool isLoadingCategory = true;
  bool isLoadingMeal = true;
  RxBool isLoadingRandom = false.obs;
  Meal? meal;

  @override
  void onInit() {
    super.onInit();
    getUser();
    getCategoriesData();
  }

  Future<void> onRefresh() async {
    getUser();
    getCategoriesData();
  }

  void selectCategory(int index) {
    if (selectedCategory?.strCategory != categories[index].strCategory) {
      catIndex = index;
      selectedCategory = categories[index];
      meals = [];
      getMealsData();
      update();
    }
  }

  /// Get User
  Future<void> getUser() async {
    user = await StorageHelper.getUser();
    user = await firebaseRepo.getUser();
    update();
  }

  /// Get Categories
  Future<void> getCategoriesData() async {
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
      isLoadingCategory = false;
      update();
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
    }
  }

  /// Get Meals
  Future<void> getMealsData() async {
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
      isLoadingMeal = false;
      update();
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
    }
  }

  /// Random Food Lookup
  Future<void> randomFoodLookup() async {
    try {
      isLoadingRandom = true.obs;
      update();
      ResponseModel responseModel = await mealRepo.getRandomSingleMeal();
      if (responseModel.statusCode == 200) {
        MealResponse response = MealResponse.fromJson(
          responseModel.responseJson,
        );

        meal = response.meals?.first;
        isLoadingRandom = false.obs;
        update();
        if (meal != null) {
          Get.toNamed(RouteHelper.recipeDetail);
        } else {
          error(
            context: Get.context!,
            title: 'error'.tr,
            message: 'something_wrong'.tr,
          );
        }
      }
    } catch (e) {
      isLoadingRandom = false.obs;
      update();
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      GoogleSignIn google = GoogleSignIn();
      bool isSignedIn = await google.isSignedIn();
      if (isSignedIn) await google.signOut();
      await auth.signOut();

      StorageHelper.logout();
      Get.offAllNamed(RouteHelper.login);
      success(
        context: Get.context!,
        title: 'success'.tr,
        message: 'logout_successful'.tr,
      );
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
    }
  }

  ///Delete Dialog
  Future<void> deleteDialog() async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return GiffyDialog.image(
          Image.asset(
            Assets.images.delete.path,
            height: 200,
            fit: BoxFit.cover,
          ),
          title: Text(
            'delete_forever_title'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'delete_forever_content'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () => deleteAllUserData(),
              child: const Text(
                'Delete Forever',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Delete All User Data
  Future<void> deleteAllUserData() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn google = GoogleSignIn();

      await firebaseRepo.deleteUser();

      final User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await currentUser.delete();
      } else {
        printError("No Firebase user found to delete or already deleted.");
      }

      final bool isSignedInWithGoogle = await google.isSignedIn();
      if (isSignedInWithGoogle) {
        await google.disconnect();
      }

      await auth.signOut();

      StorageHelper.logout();

      Get.offAllNamed(RouteHelper.login); // Use AppRoutes as per your import
      success(
        title: 'success'.tr,
        message: 'delete_all_user_data_successful'.tr,
        context: Get.context!,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'requires-recent-login') {
        errorMessage = 're_auth_required_message'.tr;
      } else {
        errorMessage = e.message ?? 'firebase_auth_error'.tr;
      }
      error(title: 'error'.tr, message: errorMessage, context: Get.context!);
      printError("FirebaseAuthException: ${e.code} - ${e.message}");
    } catch (e) {
      printError("FirebaseAuthException: $e");
      error(
        title: 'error'.tr,
        message: '${'delete_all_user_data_failed'.tr}: ${e.toString()}',
        context: Get.context!,
      );
    } finally {}
  }
}
