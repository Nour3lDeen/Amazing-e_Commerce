import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import 'chat.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white.withValues(alpha: 0.65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 24.w),
          //EdgeInsets.all(50.sp),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextBody14('أهلا ومرحبا بك في خدمة عملاء',
                  fontSize: 16.sp, color: AppColors.primaryColor),
              GradientText(
                'Amazing',
                fontSize: 20.sp,
                strokeColor: AppColors.black,
                strokeWidth: 1,
                gradient: LinearGradient(
                    colors: [HexColor('#FFF127'), HexColor('#B0A504')]),
              ),
              SizedBox(
                height: 8.h,
              ),
              SvgPicture.asset(AppAssets.contactUs),
              SizedBox(
                height: 8.h,
              ),
              TextBody14('يسعدنا تقديم المساعدة لكم في أي وقت.'),
              SizedBox(
                height: 8.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(context: context,
                      useSafeArea: true,
                      builder: (context) => Chat());
                },
                child: Container(
                  width: double.infinity,
                  height: 34.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            offset: Offset(3.w, 3.h),
                            blurRadius: 6.0)
                      ],
                      gradient: LinearGradient(colors: [
                        HexColor('#31D3C6'),
                        HexColor('#208B78'),
                      ])),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 6.w,
                    children: [
                      TextBody14(
                        'ابدأ المحادثة',
                        color: AppColors.white,
                      ),
                      SvgPicture.asset(AppAssets.chat)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
