import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/controllers/home/home_controller.dart';
import 'package:recipe_app/data/models/list_items/area_list_item.dart';
import 'package:recipe_app/data/models/list_items/ingredient_list_item.dart';
import 'package:recipe_app/data/models/list_responses/area_list_response.dart';
import 'package:recipe_app/data/models/list_responses/ingredient_list_response.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../common/styles/text_styles.dart';
import '../../util/colors_util.dart';
import '../../util/controller_export.dart';

class SearchMealController extends GetxController {
  MealRepo mealRepo = MealRepo();
  int? catIndex = 0;
  int? areaIndex;
  int? indgreIndex;
  bool isLoadingMeal = false;
  bool isLoadingCategory = false;
  bool isLoadingArea = false;
  bool isLoadingIngredient = false;
  CategoryListItem? selectedCategory;
  AreaListItem? selectedArea;
  IngredientListItem? selectedIngred;
  List<CategoryListItem> categories = [];
  List<AreaListItem> areas = [];
  List<IngredientListItem> ingredients = [];
  List<FilteredMealItem> meals = [];
  List<FilteredMealItem> filterMeals = [];
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCategoriesData();
    getAreasData();
    getIngredientsData();

  }

  Future<void> onRefresh() async {
    getCategoriesData();
    getAreasData();
    getIngredientsData();
    Get.find<HomeController>().getUser();
  }


  /// Select Category
  selectCategory(index) {
    if (selectedCategory?.strCategory != categories[index].strCategory) {
      catIndex = index;
      areaIndex = null;
      indgreIndex = null;
      selectedCategory = categories[index];
      selectedArea = null;
      selectedIngred = null;
      meals = [];
      getMealsData();
      update();
    }
  }

  /// Select Area
  selectArea(index) {
    if (selectedArea?.strArea != areas[index].strArea) {
      catIndex = null;
      areaIndex = index;
      indgreIndex = null;
      selectedCategory = null;
      selectedArea = areas[index];
      selectedIngred = null;
      meals = [];
      getMealsData();
      update();
    }
  }

  searchMeal(String value) {
    filterMeals =
        meals
            .where(
              (data) =>
                  data.strMeal!.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
    update();
  }

  /// Select Ingredient
  selectIngredient(index) {
    if (selectedIngred?.strIngredient != ingredients[index].strIngredient) {
      catIndex = null;
      areaIndex = null;
      indgreIndex = index;
      selectedCategory = null;
      selectedArea = null;
      selectedIngred = ingredients[index];
      meals = [];
      getMealsData();
      update();
    }
  }

  /// Get Categories
  getCategoriesData() async {
    try {
      if (categories.isNotEmpty) {
        return;
      }

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

  /// Get Areas
  getAreasData() async {
    try {
      if (areas.isNotEmpty) {
        return;
      }
      isLoadingArea = true;
      update();

      ResponseModel responseModel = await mealRepo.getFilter('a=list');
      if (responseModel.statusCode == 200) {
        AreaListResponse response = AreaListResponse.fromJson(
          responseModel.responseJson,
        );

        areas = response.areas ?? [];

        if (selectedArea == null) {
          selectedArea = areas.first;
          getMealsData();
          update();
        }

        isLoadingArea = false;
        update();
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      isLoadingArea = false;
      update();
    }
  }

  /// Get Ingredients
  getIngredientsData() async {
    try {
      if (ingredients.isNotEmpty) {
        return;
      }
      isLoadingIngredient = true;
      update();

      ResponseModel responseModel = await mealRepo.getFilter('i=list');
      if (responseModel.statusCode == 200) {
        IngredientListResponse response = IngredientListResponse.fromJson(
          responseModel.responseJson,
        );

        ingredients = response.ingredients ?? [];

        if (selectedIngred == null) {
          selectedIngred = ingredients.first;
          getMealsData();
          update();
        }

        isLoadingIngredient = false;
        update();
      }
    } catch (e) {
      error(title: 'error'.tr, context: Get.context!, message: e.toString());
      isLoadingIngredient = false;
      update();
    }
  }

  /// Get Meals Data
  getMealsData() async {
    try {
      isLoadingMeal = true;
      update();
      late ResponseModel responseModel;
      if (selectedCategory != null) {
        responseModel = await mealRepo.getFilterByCategory(
          selectedCategory?.strCategory ?? '',
        );
      } else if (selectedArea != null) {
        responseModel = await mealRepo.getFilterByArea(
          selectedArea?.strArea ?? '',
        );
      } else if (selectedIngred != null) {
        responseModel = await mealRepo.getFilterByIngredient(
          selectedIngred?.strIngredient ?? '',
        );
      }

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

  ///Pop Menu
  openedFilterFun([bool open = false]) {
    Get.toNamed(RouteHelper.searchRecipe);
    if (open) {
      Future.delayed(
        Duration(milliseconds: 500),
        () => filterWidget(Get.context!),
      );
    }
  }

  Future<dynamic> filterWidget(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return GetBuilder<SearchMealController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'filter_search'.tr,
                        style: TextStyles.semiBold.copyWith(fontSize: 14.sp),
                      ),
                    ).paddingOnly(bottom: 15.h),
                    Text(
                      'category'.tr,
                      style: TextStyles.semiBold.copyWith(fontSize: 14),
                    ).paddingOnly(bottom: 10.h),
                    isLoadingCategory
                        ? filterShimmer()
                        : Wrap(
                          children: List.generate(categories.length, (index) {
                            return GestureDetector(
                              onTap: () => selectCategory(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      index == catIndex
                                          ? ColorsUtil.primary
                                          : Colors.transparent,
                                  border: Border.all(color: ColorsUtil.primary),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  categories[index].strCategory ?? '',
                                  style: TextStyles.normal.copyWith(
                                    fontSize: 11.sp,
                                    color:
                                        index == catIndex
                                            ? ColorsUtil.white
                                            : ColorsUtil.primary,
                                  ),
                                ),
                              ).paddingOnly(right: 10.w, bottom: 10.h),
                            );
                          }),
                        ).paddingOnly(bottom: 5.h),

                    Text(
                      'area'.tr,
                      style: TextStyles.semiBold.copyWith(fontSize: 14),
                    ).paddingOnly(bottom: 10.h),
                    isLoadingArea
                        ? filterShimmer()
                        : Wrap(
                          children: List.generate(areas.length, (index) {
                            return GestureDetector(
                              onTap: () => selectArea(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      index == areaIndex
                                          ? ColorsUtil.primary
                                          : Colors.transparent,
                                  border: Border.all(color: ColorsUtil.primary),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  areas[index].strArea ?? '',
                                  style: TextStyles.normal.copyWith(
                                    fontSize: 11.sp,
                                    color:
                                        index == areaIndex
                                            ? ColorsUtil.white
                                            : ColorsUtil.primary,
                                  ),
                                ),
                              ).paddingOnly(right: 10.w, bottom: 10.h),
                            );
                          }),
                        ).paddingOnly(bottom: 5.h),

                    Text(
                      'ingredients'.tr,
                      style: TextStyles.semiBold.copyWith(fontSize: 14),
                    ).paddingOnly(bottom: 10.h),
                    isLoadingIngredient
                        ? filterShimmer()
                        : Wrap(
                          children: List.generate(ingredients.length, (index) {
                            return GestureDetector(
                              onTap: () => selectIngredient(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      index == indgreIndex
                                          ? ColorsUtil.primary
                                          : Colors.transparent,
                                  border: Border.all(color: ColorsUtil.primary),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  ingredients[index].strIngredient ?? '',
                                  style: TextStyles.normal.copyWith(
                                    fontSize: 11.sp,
                                    color:
                                        index == indgreIndex
                                            ? ColorsUtil.white
                                            : ColorsUtil.primary,
                                  ),
                                ),
                              ).paddingOnly(right: 10.w, bottom: 10.h),
                            );
                          }),
                        ).paddingOnly(bottom: 5.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  filterShimmer() {
    return Wrap(
      children: List.generate(6, (index) {
        return Shimmer(
          child: Container(
            width: 50.w,
            height: 20.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: ColorsUtil.greyBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ).paddingOnly(right: 10.w, bottom: 10.h),
        );
      }),
    );
  }
}
