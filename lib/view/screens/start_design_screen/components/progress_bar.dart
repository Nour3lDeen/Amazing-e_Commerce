import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.currentStep});

  final int totalSteps = 7;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps * 2 - 1, (index) {
          int stepNumber = totalSteps - (index ~/ 2); // Reverse the order
          bool isActive = stepNumber == currentStep;
          bool isDone = stepNumber < currentStep;

          if (index % 2 == 0) {
            return Container(
              height: 22.h,
              width: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? HexColor('#7AABA3')
                    : isDone
                    ? AppColors.primaryColor
                    : HexColor('#BEBEBE'),
              ),

              child: !isDone
                  ? Center(
                    child: Text(
                        stepNumber.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  )
                  : Center(
                    child: SvgPicture.asset(
                        AppAssets.sectionDone,
                        height: 14.h,
                        width: 16.w,
                      ),
                  ),
            );
          } else {
            // Dashed line between steps
            return Row(
              children: [
                // First Divider with conditional color
                Container(
                  height: 1.h,
                  width: 6.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Divider(
                    color: (stepNumber <= currentStep)
                        ? AppColors.primaryColor // Active step
                        : (stepNumber == currentStep)
                        ? HexColor('#7AABA3') // Completed step
                        : HexColor('#BEBEBE'), // Pending step
                    thickness: 1.h,
                  ),
                ),
                // Second Divider with conditional color
                Container(
                  height: 1.h,
                  width: 6.w,
                  margin: EdgeInsets.only(left: 4.w),
                  child: Divider(
                    color: (stepNumber == currentStep+1)
                        ? HexColor('#7AABA3') // Active step
                        : (stepNumber < currentStep+1)
                        ? AppColors.primaryColor // Completed step
                        : HexColor('#BEBEBE'), // Pending step
                    thickness: 1.h,
                  ),
                ),
              ],
            );

          }
        }),
      ),
    );
  }
}
