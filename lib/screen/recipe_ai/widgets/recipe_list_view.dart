// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:recipe_app/controllers/home/home_controller.dart';
import 'package:recipe_app/controllers/recipe_ai/recipe_ai_controller.dart';

import '../../../data/models/recipe_ai_model.dart';
import '../../../data/models/user_model.dart';
import '../../../util/app_export.dart';
import '../../../util/firebase_util.dart';
import 'recipe_view.dart';

class RecipeListView extends StatelessWidget {

  final controller = Get.find<RecipeAiController>();
  final _expanded = <String, bool>{};

  RecipeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeAiController>(
      builder: ( controller) {
        return StreamBuilder(
            stream: FirebaseUtil.users.doc(Get.find<HomeController>().user!.id).snapshots(),
            builder: (context,AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              UserModel user = UserModel.from(snapshot.data.data());
              List<RecipeAIModel> recipes = RecipeAIModel.loadFrom(user.aiRecipes);
              final displayedRecipes = controller.filteredRecipes(recipes).toList();
              return ListView.builder(
                itemCount: displayedRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = displayedRecipes[index];
                  final recipeId = recipe.id;
                  return RecipeView(
                    key: ValueKey(recipeId),
                    recipe: recipe,
                    expanded: _expanded[recipeId] == true,
                    onExpansionChanged:
                        (expanded) => _onExpand(recipe.id, expanded),
                    onEdit: () => _onEdit(recipe),
                    onDelete: () => controller.onDeleteFun(recipe,context),
                  );
                },
              );
            },
          );
      }
    );
  }

  void _onExpand(String recipeId, bool expanded) =>
      _expanded[recipeId] = expanded;

  void _onEdit(RecipeAIModel recipe) =>
      Get.find<RecipeAiController>().selectedRecipeFun(recipe);

}