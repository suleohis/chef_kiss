part of '../bookmark_screen.dart';

class BookmarkShimmer extends StatelessWidget {
  const BookmarkShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: 10,
      itemBuilder: (_, index) {
        return Shimmer(
          child: Container(
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: ColorsUtil.greyBg
            ),
          ).paddingOnly(bottom: 15.h,),
        );
      },
    );
  }
}
