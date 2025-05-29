import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../util/app_export.dart';

class RecipeDetailController extends GetxController {
  RxInt tabIndex  = 0.obs;
  YoutubePlayerController youtubeController = YoutubePlayerController();

  @override
  void onInit() {
    super.onInit();
    youtubeInit();
  }

  youtubeInit() {
     youtubeController = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(
        'https://www.youtube.com/watch?v=DZIASl9q90s',
      )!,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  onTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
