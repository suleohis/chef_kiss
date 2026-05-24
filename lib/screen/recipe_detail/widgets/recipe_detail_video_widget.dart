part of '../recipe_detail_screen.dart';

class RecipeDetailVideoWidget extends StatelessWidget {
  final Meal meal;

  /// The player widget provided by [YoutubePlayerBuilder].
  /// When this is non-null the video is available and ready for fullscreen.
  /// When null the recipe has no YouTube link, so we show the thumbnail.
  final Widget? player;

  const RecipeDetailVideoWidget({
    super.key,
    required this.meal,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    // No YouTube link — show the recipe thumbnail instead.
    if (player == null) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: CachedNetworkImage(
            imageUrl: meal.strMealThumb ?? '',
            fit: BoxFit.fitWidth,
            height: 200.h,
            errorWidget: (_, url, error) => Image.asset(
              Assets.images.noImage.path,
              height: 200.h,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
    }

    // YoutubePlayerBuilder hands us this widget. It renders inline here,
    // and on fullscreen the builder repositions it to cover the entire screen
    // (status bar, AppBar, nav bar — everything), matching YouTube's behaviour.
    return player!;
  }
}
