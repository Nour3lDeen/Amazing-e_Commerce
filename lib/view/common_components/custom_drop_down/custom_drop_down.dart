import 'package:easy_localization/easy_localization.dart';
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
    this.validator, this.fillColor, this.hintColor, this.borderRadius, this.hasShadow,
  });

  final String title;
  final String icon;
  final Color titleColor;
  final String hint;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;
final Color? fillColor;
  final Color? hintColor;
  final double? borderRadius;
  final bool? hasShadow;
  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    // Determine text alignment and direction based on locale
    final isRTL = locale.languageCode == 'ar';
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
              TextBody12(
                title,
                textAlign: isRTL ? TextAlign.right : TextAlign.left,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ],
          ),
        ),
        Container(
          decoration: hasShadow==true? BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: Offset(0.0, 3.h),
                blurRadius: 6.0,
              )
            ]
          ):null,
          child: DropdownButtonFormField<String>(

            isExpanded: true,
            value: value,
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: TextBody14(
                      item,
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.black,
                    ),
                  ),
                )
                .toList(),
          isDense: true,
            onChanged: onChanged,
            validator: validator,
            hint: TextBody12(
              fontSize: 10.sp,
              hint,
              color: hintColor ?? AppColors.grey,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(right: 8.w, left: 8.w, bottom: 5.h),
              fillColor: fillColor ?? AppColors.white.withValues(alpha: 0.4),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        )
      ],
    );
  }
}
