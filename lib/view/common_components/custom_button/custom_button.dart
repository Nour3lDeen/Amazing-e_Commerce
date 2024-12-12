import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.child,
    this.backgroundColor,
    this.elevationColor,
    this.elevation,
    this.borderRadius,
  });

  final void Function()? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? elevationColor;
  final double? elevation;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return  Material(
      borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
      color: backgroundColor ?? AppColors.primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.primaryColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
              gradient: LinearGradient(
                  colors: [
                    HexColor('#39FAD9'),
                    HexColor('#03A186'),
                  ]
              )
          ),
          child: child,
        ),
      ),
    );
  }

}
