import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipe_app/controllers/search/search_meal_controller.dart';
import 'package:recipe_app/controllers/home/home_controller.dart';

import '../../util/app_export.dart';

part 'widgets/home_headers_widget.dart';
part 'widgets/home_body_widget.dart';
part 'widgets/home_shimmer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Get.find<HomeController>().onRefresh(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeadersWidget(),
                HomeBodyWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
