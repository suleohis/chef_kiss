import 'package:recipe_app/controllers/home/home_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../util/controller_export.dart';

class RecipeDetailController extends GetxController {
  MealRepo mealRepo = MealRepo();
  FirebaseRepo firebaseRepo = FirebaseRepo();
  final String mealId;
  RecipeDetailController({required this.mealId});
  RxInt tabIndex = 0.obs;
  Meal? meal;
  YoutubePlayerController? youtubeController;
  RxBool isLoading = false.obs;
  UserModel? user;
  RxBool isBookmark = false.obs;


  @override
  void onInit() {
    super.onInit();
    getRecipeData();
  }

  @override
  void dispose() {
    super.dispose();
    youtubeController!.dispose();
  }

  Future<void> onRefresh() async {
    getRecipeData();
  }

  ///Add or Remove from bookmark
  onBookmark() {
    if (isBookmark.value) {
      user!.bookmark.remove(meal!.idMeal);
    } else {
      user!.bookmark.add(meal!.idMeal);
    }
    saveUser();
  }

  /// save User
  saveUser() async {
    await firebaseRepo.saveUser(user!).then((value) {
      if (value) {
        isBookmark.value = user?.bookmark.contains(meal!.idMeal) ?? false;
        if (isBookmark.value) {
          success(context: Get.context!, title: 'success'.tr, message: 'bookmark_added'.tr);
        } else {
          success(context: Get.context!, title: 'success'.tr, message: 'bookmark_removed'.tr);
        }
      } else {
        error(context: Get.context!, title: 'error'.tr, message: 'something_wrong'.tr);
      }
    });
    update();
  }

  /// get User
  getUser() async {
   user = await firebaseRepo.getUser();
   isBookmark.value = user?.bookmark.contains(meal!.idMeal) ?? false;
    update();
  }

  getRecipeData() async {
    try {
      if (Get.find<HomeController>().meal != null) {

        meal = Get.find<HomeController>().meal;
        Get.find<HomeController>().meal = null;
        if (meal != null && (meal?.strYoutube?.isNotEmpty ?? false)) youtubeInit();
        getUser();
        return;
      }
      isLoading.value = true;
      update();

      ResponseModel responseModel = await mealRepo.getLookupMealDetail(mealId);
      if (responseModel.statusCode == 200) {
        MealResponse response = MealResponse.fromJson(
          responseModel.responseJson,
        );

        meal = response.meals?.firstOrNull;
        isLoading.value = false;
        update();
        if (meal != null && (meal?.strYoutube?.isNotEmpty ?? false)) youtubeInit();
        getUser();
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      isLoading.value = false;
      update();
    }
  }

  youtubeInit() {
    String videoUrl = meal?.strYoutube ?? '';
    final videoId = YoutubePlayer.convertUrlToId(
      videoUrl,
    ); // Extract video ID from URL
    if (videoId != null) {
      youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    } else {
      // Handle invalid YouTube URL
      printWarning('Invalid YouTube URL: $videoUrl');
      // You might want to display an error message to the user
    }
  }

  onTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
