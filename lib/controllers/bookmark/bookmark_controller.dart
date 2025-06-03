import 'package:recipe_app/util/controller_export.dart';

import '../home/home_controller.dart';

class BookmarkController extends GetxController {
  MealRepo mealRepo = MealRepo();
  UserModel? user;
  List<Meal> meals = [];
  bool isLoading = false;

  @override
  void onInit() async {
    super.onInit();
    user = await StorageHelper.getUser();
    getBookmarkData();
  }

  Future<void> onRefresh() async {
    Get.find<HomeController>().getUser();
    getBookmarkData();
  }

  getBookmarkData() async {
    try {
      isLoading = true;
      update();
      for (var mealId in user!.bookmark) {
        ResponseModel responseModel = await mealRepo.getLookupMealDetail(
          mealId,
        );
        if (responseModel.statusCode == 200) {
          MealResponse response = MealResponse.fromJson(
            responseModel.responseJson,
          );

          meals.addAll(response.meals ?? []);
          isLoading = false;
          update();
        }
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      isLoading = false;
      update();
    }
  }
}
