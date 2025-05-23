import '../../util/app_export.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool disable;
  final String text;
  final Color? background;
  final Color? foreground;
  final TextStyle? style;
  final EdgeInsets? padding;
  final Widget? suffix;
  final Size? size;
  final bool isLoading;
  final BorderRadius? borderRadius;
  const CustomButton({
    super.key,
    required this.onPressed,
    this.disable = false,
    required this.text,
    this.background,
    this.foreground,
    this.style,
    this.padding,
    this.suffix,
    this.size,
    this.borderRadius,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foreground,
        disabledBackgroundColor: ColorsUtil.greyBg,
        disabledForegroundColor: ColorsUtil.white,
        backgroundColor: background,
        padding: padding ?? EdgeInsets.symmetric(vertical: 18),
        fixedSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10.r),
        ),
      ),
      child:
          isLoading
              ? Center(
                child: CircularProgressIndicator(color: ColorsUtil.white),
              )
              : Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    text,
                    style:
                        style ??
                        TextStyles.semiBold.copyWith(
                          fontSize: 16.sp,
                          color: foreground,
                        ),
                  ),
                  if (suffix != null) suffix!.paddingOnly(left: 10),
                ],
              ),
    );
  }
}
