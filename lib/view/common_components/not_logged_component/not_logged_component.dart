import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/app_assets/app_assets.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';
import '../../../view_model/utils/navigation/navigation.dart';
import '../../screens/auth/login_screen/login_screen.dart';
import '../custom_button/custom_button.dart';

class NotLoggedComponent extends StatelessWidget {
  const NotLoggedComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 240.w,
        height: 160.h,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: Image.asset(AppAssets.containerBackground).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.primaryColor,
              size: 50.sp,
            ),
            TextBody14(
              'أنت لم تقم بتسجيل الدخول\nالتوجه لتسجيل الدخول؟',
              color: AppColors.black,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigation.push(context, const LoginScreen());
                  },
                  gradient: LinearGradient(colors: [
                    HexColor(
                      '#31D3C6',
                    ),
                    HexColor(
                      '#208B78',
                    )
                  ]),
                  borderRadius: 8.r,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: SizedBox(
                      width: 95.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextBody12(
                            'تسجيل',
                            color: AppColors.white,
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            AppAssets.login,
                            height: 16.h,
                            width: 16.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  backgroundColor: AppColors.white,
                  child: Container(
                    width: 95.w,
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBody12(
                          'إلغاء',
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.cancel_outlined,
                          size: 16.sp,
                          color: AppColors.primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
