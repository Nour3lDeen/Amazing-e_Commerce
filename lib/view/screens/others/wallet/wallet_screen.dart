import 'dart:ui';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../view_model/data/local/shared_keys.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PositionedDirectional(
          start: 0,
          top: 0.h,
          end: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: SharedHelper.getData(SharedKeys.platform) == 'android'
                    ? 32.h
                    : 48.h),
            width: double.infinity,
            height: 240.h,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: Image.asset(AppAssets.othersBack).image,
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                offset: Offset(0.0, 1.h),
                                blurRadius: 15,
                                spreadRadius: 1),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppAssets.backIcon1,
                          height: 30.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 75.w,
                    ),
                    GradientText(
                      'رصيد المحفظة',
                      gradient: LinearGradient(
                        colors: [
                          HexColor('#DCCF0F'),
                          HexColor('#8B8309'),
                        ],
                      ),
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          offset: Offset(1.w, 3.h),
                          blurRadius: 6,

                        ),
                      ],
                      fontSize: 18.sp,
                    )
                  ],
                ),
                SvgPicture.asset(
                  AppAssets.walletLogo,
                  height: 75.h,
                  width: 75.w,
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          start: 0,
          top: 170.h,
          bottom: 0,
          end: 0,
          child: ClipRRect(
            // clipBehavior:Clip.none,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r)),
                  color: AppColors.white.withValues(alpha: 0.6),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.asset(
                      AppAssets.customBack,
                      height: double.infinity,
                      width: double.infinity,
                    ).image,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 240.w,
                      height: 180.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 32.h),
                      decoration: BoxDecoration(
                        color: AppColors.othersColor,
                        border: Border.all(
                          color: AppColors.secondaryColor,
                          width: 1.sp,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            offset: Offset(0.0, 3.h),
                            blurRadius: 6.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.r),
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r)),
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextBody14(
                              'رصيد المحفظة الخاص بكم',
                              fontWeight: FontWeight.bold,
                            ),
                            GradientText(
                              '00.00  ر.س',
                              gradient: LinearGradient(colors: [
                                HexColor('#D9D04D'),
                                HexColor('#988F06'),
                              ]),
                              fontSize: 20.sp,
                            )
                          ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 36.h,

                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              HexColor('#39FAD9'),
                              HexColor('#03A186'),
                            ]),
                            borderRadius: BorderRadius.circular(
                              14.r,
                            )),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 6.w,
                            children: [
                              TextBody14(
                                'رجوع',
                                fontSize: 16.sp,
                                color: AppColors.white,
                              ),
                            SvgPicture.asset(AppAssets.backIcon2,height: 18.h,)
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
