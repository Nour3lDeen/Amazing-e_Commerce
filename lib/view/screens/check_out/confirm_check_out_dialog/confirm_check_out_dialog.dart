import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';
class ConfirmCheckOutDialog extends StatelessWidget {
  const ConfirmCheckOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white.withValues(alpha: 0.65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6.0,
          sigmaY: 6.0,
        ),
        child: Container(
          width: 300.w,
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
           children: [
             SvgPicture.asset(AppAssets.confirmCheckOut),
             TextTitle('تم تأكيد طلبك بنجاح',color: AppColors.primaryColor,),
             GradientText('Amazing',
                 fontSize: 22.sp,
                 shadows: [
                   Shadow(
                     color: AppColors.black.withValues(alpha: 0.15),
                     offset: Offset(1.w, 3.h),
                     blurRadius: 6.0,
                   ),
                 ],
                 gradient: LinearGradient(
               colors: [
                 HexColor('#FFF127'),
                 HexColor('#B0A504'),
               ],
             )),
             TextBody14('"تتمني لك وقتاً طيباً!"',color: AppColors.black,),
           ],
          ),
        ),
      ),
    );
  }
}
