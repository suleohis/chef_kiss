part of '../recipe_detail_screen.dart';

class RecipeDetailVideoWidget extends StatelessWidget {
  final Meal meal;
  final YoutubePlayerController? youtubeController;
  const RecipeDetailVideoWidget({
    super.key,
    required this.meal,
    required this.youtubeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (meal.strYoutube == null || (meal.strYoutube?.isEmpty ?? false))
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: meal.strMealThumb ?? '',
                fit: BoxFit.fitWidth,
                height: 200.h,
                errorWidget:
                    (_, url, error) => Image.asset(
                      Assets.images.noImage.path,
                      height: 200.h,
                      fit: BoxFit.fitWidth,
                    ),
              ),
            ),
          )
        else
          SizedBox(
            height: 200.h,
            width: 500.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: YoutubePlayer(
                controller: youtubeController!,
                liveUIColor: ColorsUtil.primary,
              ),
            ),
          ),
      ],
    );
  }
}
