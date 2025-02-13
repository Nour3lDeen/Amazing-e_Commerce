import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.title,
      required this.hint,
      this.icon,
      required this.titleColor,
      required this.isPassword,
      required this.controller,
      required this.onIconTap,
      required this.suffixIcon,
      required this.obscureText,
      this.keyboardType,
      this.validator,
      this.onTap,
      this.readOnly,
      this.textInputAction,
      this.onSubmitted,
      this.fillColor,
      this.hintColor,
      this.borderRadius,
      this.maxLines, this.hasShadow});

  final String title;
  final Color titleColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool obscureText;
  final String hint;
  final String? icon;
  final void Function() onIconTap;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final TextEditingController controller;
  final Icon suffixIcon;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? hintColor;
  final double? borderRadius;
  final int? maxLines;
final bool? hasShadow;
  @override
  Widget build(BuildContext context) {
    // Get the current locale
    final locale = context.locale;

    // Determine text alignment and direction based on locale
    final isRTL = locale.languageCode == 'ar';

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Row(
          children: [
            Visibility(
                visible: icon != null,
                child: SvgPicture.asset(icon ?? '', height: 16.h, width: 16.w)),
            SizedBox(
              width: 8.w,
            ),
            TextBody12(
              title,
              fontSize: 12.sp,
              textAlign: isRTL ? TextAlign.right : TextAlign.left,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ],
        ),
      ),
      Container(
        decoration:hasShadow==true? BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: Offset(0.0, 3.h),
                blurRadius: 6.0,
              ),
            ]):null,
        child: TextFormField(
          autofocus: false,
          textInputAction: textInputAction ?? TextInputAction.next,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          maxLines: maxLines ?? 1,
          onFieldSubmitted: onSubmitted,
          cursorColor: AppColors.primaryColor,
          onTap: onTap,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          textAlign: isRTL ? TextAlign.right : TextAlign.left,
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            suffixIcon: isPassword
                ? IconButton(
                    icon: suffixIcon,
                    onPressed: () {
                      onIconTap();
                    },
                  )
                : null,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 10.sp,
              color: hintColor ?? AppColors.grey,
              fontFamily: 'Lamar',
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            fillColor: fillColor ?? AppColors.white.withValues(alpha: 0.4),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none),
          ),
        ),
      )
    ]);
  }
}
