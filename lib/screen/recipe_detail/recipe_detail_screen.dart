import 'package:recipe_app/controllers/recipe_detail/recipe_detail_controller.dart';
import 'package:recipe_app/data/models/meal_ingredient.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../data/models/meal.dart';
import '../../util/app_export.dart';
part 'widgets/recipe_detail_shimmer.dart';
part 'widgets/recipe_detail_body.dart';
part 'widgets/recipe_detail_video_widget.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeDetailController controller = Get.find<RecipeDetailController>();
  RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeDetailController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton.icon(
                onPressed: () => controller.onBookmark(),
                style: TextButton.styleFrom(
                  foregroundColor:
                      controller.isBookmark.value ? ColorsUtil.primary : ColorsUtil.black,
                ),
                icon: Icon(
                  controller.isBookmark.value
                      ? Icons.bookmark_outlined
                      : Icons.bookmark_outline_rounded,
                ),
                label: Text(
                  controller.isBookmark.value? 'unsaved'.tr : 'save'.tr,
                  style: TextStyles.normal.copyWith(
                    fontSize: 14.sp,
                    color:
                    controller.isBookmark.value
                            ? ColorsUtil.primary
                            : ColorsUtil.black,
                  ),
                ),
              ).paddingOnly(right: 20.w),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.onRefresh(),
            child: Obx(
              () =>
                  controller.isLoading.value || controller.meal == null
                      ? RecipeDetailShimmer()
                      : RecipeDetailBody(controller: controller),
            ),
          ),
        );
      }
    );
  }
}
