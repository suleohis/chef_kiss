import '../../util/app_export.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? errorText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextStyle? style;
  final bool? hidePassword;
  final Widget? suffix;
  final Widget? prefix;
  final TextCapitalization? textCapitalization;
  final EdgeInsets? padding;
  final void Function()? onTap;
  final bool autoFocus;
  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.errorText,
    this.onChanged,
    this.validator,
    this.textInputType,
    this.style,
    this.hidePassword,
    this.suffix,
    this.textCapitalization, this.padding, this.prefix, this.onTap, this.autoFocus = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyles.normal.copyWith(fontSize: 14.sp),
          ).paddingOnly(bottom: 5.h),

        TextFormField(
          obscureText: hidePassword ?? false,
          autofocus: autoFocus,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: textInputType,
          style: style ?? TextStyles.normal,
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            hintStyle: TextStyles.normal.copyWith(fontSize: 11.sp, color: ColorsUtil.grey),
            contentPadding: padding ?? EdgeInsets.all(20),
            suffixIcon: suffix,
            prefix: prefix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: ColorsUtil.greyBg, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: ColorsUtil.greyBg, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: ColorsUtil.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: ColorsUtil.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: ColorsUtil.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
