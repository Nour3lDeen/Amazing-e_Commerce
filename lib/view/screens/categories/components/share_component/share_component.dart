import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../view_model/utils/app_assets/app_assets.dart';


class ShareComponent extends StatelessWidget {
  const ShareComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.6),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0,0),
          )
        ],
      ),
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: EdgeInsets.all(4.sp),
          child: SvgPicture.asset(
            AppAssets.share,
            height: 12.h,
            width: 12.w,
          ),
        ),
      ),
    );
  }
}
