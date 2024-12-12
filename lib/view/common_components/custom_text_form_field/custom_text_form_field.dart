import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
      this.readOnly, this.textInputAction});

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
  final TextEditingController controller;
  final Icon suffixIcon;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Row(
          children: [
            Visibility
              (visible: icon != null,
                child: SvgPicture.asset(icon??'', height: 16.h, width: 16.w)),
            SizedBox(
              width: 8.w,
            ),
            TextBody14(
              title,
              textAlign: TextAlign.right,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ],
        ),
      ),
      TextFormField(
        autofocus: false,
        textInputAction: textInputAction??TextInputAction.next,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        cursorColor: AppColors.primaryColor,
        onTap: onTap,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
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
            color: AppColors.grey,
            fontFamily: 'Lamar',
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          fillColor: AppColors.white.withOpacity(0.4),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none),
        ),
        textDirection: TextDirection.ltr,
      )
    ]);
  }
}
