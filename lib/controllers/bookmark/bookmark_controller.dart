import 'package:recipe_app/util/controller_export.dart';

import '../home/home_controller.dart';

class BookmarkController extends GetxController {
  MealRepo mealRepo = MealRepo();
  UserModel? user;
  List<Meal> meals = [];
  bool isLoading = false;
  bool isFetchingMore = false; // true while additional items are still arriving

  @override
  void onInit() async {
    super.onInit();
    user = await StorageHelper.getUser();
    await getBookmarkData();
  }

  Future<void> onRefresh() async {
    await Get.find<HomeController>().getUser();
    user = Get.find<HomeController>().user;
    await getBookmarkData();
  }

  Future<void> getBookmarkData() async {
    try {
      meals = [];
      final bookmarks = user?.bookmark ?? [];

      if (bookmarks.isEmpty) {
        // Nothing to fetch — skip straight to done after a short shimmer
        isLoading = true;
        update();
        await Future.delayed(const Duration(milliseconds: 600));
        isLoading = false;
        update();
        return;
      }

      // Show shimmer for the very first load
      isLoading = true;
      update();

      // Fetch the first item, then hide the shimmer so the list appears
      final firstId = bookmarks.first;
      final firstResponse = await mealRepo.getLookupMealDetail(firstId);
      if (firstResponse.statusCode == 200) {
        meals.addAll(
          MealResponse.fromJson(firstResponse.responseJson).meals ?? [],
        );
      }

      await Future.delayed(const Duration(milliseconds: 400));
      isLoading = false;
      isFetchingMore = bookmarks.length > 1;
      update();

      // Fetch the remaining bookmarks one by one — each appears as it arrives
      for (int i = 1; i < bookmarks.length; i++) {
        final responseModel =
            await mealRepo.getLookupMealDetail(bookmarks[i]);
        if (responseModel.statusCode == 200) {
          meals.addAll(
            MealResponse.fromJson(responseModel.responseJson).meals ?? [],
          );
          if (i == bookmarks.length - 1) isFetchingMore = false;
          update(); // triggers a rebuild → new item animates in via StaggeredListItem
        }
      }

      isFetchingMore = false;
      update();
    } catch (e) {
      isLoading = false;
      isFetchingMore = false;
      update();
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
    }
  }
}
