import '../../util/app_export.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.homeBg,
      bottomNavigationBar: Container(
        color: ColorsUtil.white,
        child: BottomAppBar(
          elevation: 9,
          color: ColorsUtil.white,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(FontAwesomeIcons.house, size: 19.sp, color: true ? ColorsUtil.primary : ColorsUtil.grey,),
                Icon(FontAwesomeIcons.bookmark, size: 19.sp, color: false ? ColorsUtil.primary : ColorsUtil.grey,),
                Icon(FontAwesomeIcons.bell, size: 19.sp, color: false ? ColorsUtil.primary : ColorsUtil.grey,),
                Icon(FontAwesomeIcons.user, size: 19.sp, color: false ? ColorsUtil.primary : ColorsUtil.grey,),

          ]),
        ),
      ),
    );
  }
}
