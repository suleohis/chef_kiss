import 'package:recipe_app/data/models/response_model.dart';
import 'package:recipe_app/data/services/api_service.dart';
import 'package:recipe_app/util/app_export.dart';

class MealRepo {
  Future<ResponseModel> getSearchName(String name) async {
    String url = ConstUtil.searchNameApi + name;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }

  Future<ResponseModel> getAllMealByLetter(String letter) async {
    String url = ConstUtil.getAllMealByLetterApi + letter;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }

  Future<ResponseModel> getLookupMealDetail(String mealId) async {
    String url = ConstUtil.lookupMealDetailApi + mealId;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }

  Future<ResponseModel> getRandomSingleMeal() async {
    String url = ConstUtil.randomSingleMealApi;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }

  Future<ResponseModel> getCategories() async {
    String url = ConstUtil.categoriesApi;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }

  Future<ResponseModel> getFilter(String param) async {
    String url = ConstUtil.filterApi + param;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }

  Future<ResponseModel> getFilterByIngredient(String name) async {
    String url = ConstUtil.filterByIngredientApi + name;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }

  Future<ResponseModel> getFilterByCategory(String name) async {
    String url = ConstUtil.filterByCategoryApi + name;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }

  Future<ResponseModel> getFilterByArea(String name) async {
    String url = ConstUtil.filterByAreaApi + name;
    ResponseModel response = await ApiService.getRequest(url);
    return response;
  }
}