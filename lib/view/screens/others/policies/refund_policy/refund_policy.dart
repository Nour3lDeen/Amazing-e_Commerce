import 'dart:ui';

import 'package:ecommerce/view/screens/others/policies/balance_refund_screen/balance_refund_screen.dart';
import 'package:ecommerce/view/screens/others/policies/product_refund/product_refund_screen.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/data/local/shared_helper.dart';
import '../../../../../view_model/data/local/shared_keys.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class RefundPolicy extends StatelessWidget {
  const RefundPolicy({super.key});

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
              children: [
                Row(
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
                      width: 70.w,
                    ),
                    GradientText(
                      'سياسة الإسترجاع',
                      gradient: LinearGradient(
                        colors: [
                          HexColor('#DCCF0F'),
                          HexColor('#8B8309'),
                        ],
                      ),
                      fontSize: 18.sp,
                    )
                  ],
                ),
                SvgPicture.asset(
                  AppAssets.policies,
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
                  children: [
                    TextTitle(
                      'فقط ولأول مرة مع',
                      fontSize: 18.sp,
                    ),
                    GradientText(
                      'Amazing',
                      gradient: LinearGradient(colors: [
                        HexColor('#FFF127'),
                        HexColor('#B0A504'),
                      ]),
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          offset: Offset(1.w, 1.h),
                          blurRadius: 6.0,
                        ),
                      ],
                      fontSize: 24.sp,
                    ),
                    SizedBox(height: 16.h),
                    TextBody14(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        textAlign: TextAlign.center,
                        'يمكنك استرجاع (منتجك - رصيدك) في اي وقت من خلال سياسة الاسترجاع المميزة التي نوفرها لعملائنا.'),
                    SizedBox(height: 16.h),
                    TextBody14(
                        fontSize: 16.sp,
                        textAlign: TextAlign.center,
                        color: AppColors.primaryColor,
                        'تعرف علي السياسات الخاصة بالاسترجاع لدينا!.'),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigation.push(context,const BalanceRefundScreen());
                          },
                          child: Container(
                            height: 40.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                gradient: LinearGradient(colors: [
                                  HexColor('#2BC339'),
                                  HexColor('#049312'),
                                ]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    offset: Offset(0.0, 3.h),
                                    blurRadius: 6.0,
                                  ),
                                ]),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextBody14(
                                    'استرجاع الرصيد',
                                    color: AppColors.white,
                                  ),
                                  SizedBox(width: 6.w),
                                  SvgPicture.asset(
                                    AppAssets.lightBulb,
                                    height: 20.h,
                                    width: 20.w,
                                  )
                                ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigation.push(context,const ProductRefundScreen());
                          },
                          child: Container(
                            height: 40.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                color: HexColor('#63C2B1'),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    offset: Offset(0.0, 3.h),
                                    blurRadius: 6.0,
                                  ),
                                ]),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextBody14(
                                    'استرجاع المنتج',
                                    color: AppColors.white,
                                  ),
                                  SizedBox(width: 6.w),
                                  SvgPicture.asset(
                                    AppAssets.lightBulb,
                                    height: 20.h,
                                    width: 20.w,
                                  )
                                ]),
                          ),
                        ),
                      ],
                    )
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
