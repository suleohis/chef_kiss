import 'package:recipe_app/controllers/recipe_detail/recipe_detail_controller.dart';
import 'package:recipe_app/data/models/meal_ingredient.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../data/models/meal.dart';
import '../../util/app_export.dart';
part 'widgets/recipe_detail_shimmer.dart';
part 'widgets/recipe_detail_body.dart';
part 'widgets/recipe_detail_video_widget.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final RecipeDetailController controller = Get.find<RecipeDetailController>();

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      actions: [
        Obx(
          () => TextButton.icon(
            onPressed: () => controller.onBookmark(),
            style: TextButton.styleFrom(
              foregroundColor: controller.isBookmark.value
                  ? ColorsUtil.primary
                  : ColorsUtil.black,
            ),
            icon: Icon(
              controller.isBookmark.value
                  ? Icons.bookmark_outlined
                  : Icons.bookmark_outline_rounded,
            ),
            label: Text(
              controller.isBookmark.value ? 'unsaved'.tr : 'save'.tr,
              style: TextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: controller.isBookmark.value
                    ? ColorsUtil.primary
                    : ColorsUtil.black,
              ),
            ),
          ).paddingOnly(right: 20.w),
        ),
      ],
    );
  }

  Widget _buildLoadingOrBody({Widget? player}) {
    return RefreshIndicator(
      onRefresh: () => controller.onRefresh(),
      child: Obx(
        () => controller.isLoading.value || controller.meal == null
            ? RecipeDetailShimmer()
            : RecipeDetailBody(controller: controller, player: player),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeDetailController>(
      builder: (controller) {
        // When a YouTube video is available, wrap with YoutubePlayerBuilder.
        // This is what enables true full-screen — the builder pulls the player
        // widget out of the normal layout and overlays it edge-to-edge,
        // covering the AppBar and system bars exactly like the YouTube app.
        if (controller.youtubeController != null) {
          return YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: controller.youtubeController!,
              liveUIColor: ColorsUtil.primary,
              onEnded: (_) {},
            ),
            builder: (context, player) => Scaffold(
              appBar: _buildAppBar(),
              body: _buildLoadingOrBody(player: player),
            ),
          );
        }

        // No video — plain scaffold, no YoutubePlayerBuilder needed.
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildLoadingOrBody(),
        );
      },
    );
  }
}
