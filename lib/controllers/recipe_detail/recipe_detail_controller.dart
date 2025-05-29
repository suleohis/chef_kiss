import 'package:recipe_app/common/function/print_fun.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../util/app_export.dart';

class RecipeDetailController extends GetxController {
  RxInt tabIndex = 0.obs;
  late YoutubePlayerController youtubeController;

  @override
  void onInit() {
    super.onInit();
    youtubeInit();
  }

  @override
  void dispose() {
    super.dispose();
    youtubeController.dispose();
  }

  youtubeInit([
    String videoUrl = 'https://www.youtube.com/watch?v=DZIASl9q90s',
  ]) {
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
      printFun('Invalid YouTube URL: $videoUrl');
      // You might want to display an error message to the user
    }
  }

  onTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
