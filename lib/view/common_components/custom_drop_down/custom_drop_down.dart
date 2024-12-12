import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';

class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    required this.title,
    required this.icon,
    required this.titleColor,
    required this.hint,
    required this.items,
    required this.onChanged,
    required this.value,
    this.validator,
  });

  final String title;
  final String icon;
  final Color titleColor;
  final String hint;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: Row(
            children: [
              SvgPicture.asset(icon),
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
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: Align(
                alignment: Alignment.centerRight, // Align item text to the right
                child: Text(
                  item,
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: 'Lamar',
                  ),
                  textAlign: TextAlign.right, // Align text to the right
                ),
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
          validator: validator,
          hint: Align(
            alignment: Alignment.centerRight, // Align hint to the right
            child: TextBody14(
              hint,
              color: AppColors.grey,

              textAlign: TextAlign.right, // Ensure right alignment
            ),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 16.w, left: 4.w, bottom: 5.h),
            fillColor: AppColors.white.withOpacity(0.4),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
        )

      ],
    );
  }
}
