import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../../view_model/utils/app_colors/app_colors.dart';

class StartDesignComponent extends StatelessWidget {
  const StartDesignComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 80.w, right: 14.w,  top: 16.h),
      child: Stack(clipBehavior: Clip.none, children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 8.w, right: 24.w, bottom: 8.h, top: 16.h),
                  width: 250.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    gradient: LinearGradient(colors: [
                      HexColor('#135B4F'),
                      HexColor('#35A491'),
                    ]),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(2.r),
                      bottomRight: Radius.circular(16.r),
                      topLeft: Radius.circular(2.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTitle(
                        'صمم عبارتك بنفسك',
                        color: AppColors.secondaryColor,
                        fontSize: 18.sp,
                      ),
                      SizedBox(height: 6.h),
                      Transform.translate(
                        offset: Offset(15.w, 0),
                        child: TextBody14(
                          'يمكنك تصميم منتجك بما يناسبك',
                          color: AppColors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),

            PositionedDirectional(
              top: 0.h,
              bottom: 30.h,
              end: -275.w,
              start: 0,
              child: Container(
                width: 106.w,
                height: 106.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    HexColor('#35A491'),
                    HexColor('#135B4F'),
                  ]),
                  border: Border.all(color: HexColor('#EDEDED'), width: 4),
                ),
                child: Image.asset(
                  AppAssets.boy,
                  height: 20.h,
                  width: 32.w,
                ),
              ),
            ),
          ],
        ),
        PositionedDirectional(
          top: 85.h,
          bottom: 10.h,
          start: 40.w,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                debugPrint('ابداء تصميمك - Button tapped');
                BottomNavCubit.get(context).changeIndex(1);
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Ink(
                width: 140.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: LinearGradient(colors: [
                    HexColor('#31D3C6'),
                    HexColor('#208B78'),
                  ]),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextTitle(
                      'ابدأ تصميمك',
                      color: AppColors.white,
                    ),
                    SizedBox(width: 8.w),
                    SvgPicture.asset(
                      AppAssets.scissors2,
                      height: 18.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
