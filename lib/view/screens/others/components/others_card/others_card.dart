import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class OthersCard extends StatelessWidget {
  const OthersCard({super.key, required this.title, required this.icon, this.onTap});
final String title;
final String icon;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      borderRadius: BorderRadius.circular(10.r),

      onTap: onTap,
      child: Container(
        padding:EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              offset: Offset(0.0, 3.h),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon,height: 16.h,width: 16.w,),
            SizedBox(
              width: 8.w,),
            TextBody14(title),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,),
          ],
        ),
      ),
    );
  }
}
