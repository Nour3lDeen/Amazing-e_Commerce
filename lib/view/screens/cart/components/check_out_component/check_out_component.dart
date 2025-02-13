import 'dart:ui';

import 'package:ecommerce/view/screens/check_out/check_out_screen.dart';
import 'package:ecommerce/view/screens/others/address/add_address_screen.dart';
import 'package:ecommerce/view/screens/others/address/address_screen.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class CheckOutComponent extends StatelessWidget {
  const CheckOutComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
            // height: 50.h,
            width: double.infinity,
            padding: EdgeInsets.only(
                right: 16.w, left: 16.w, bottom: 32.h, top: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r)),
              color: AppColors.white.withValues(alpha: 0.75),
              border: Border.all(color: AppColors.white, width: 2.sp),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextTitle(
                'اختر العنوان',
                color: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    right: 16.w, top: 8.h, bottom: 8.h, left: 24.w),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        offset: Offset(1.w, 3.h),
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(14.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.location1),
                    SizedBox(
                      width: 6.w,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 1.h,
                      children: [
                        TextBody14(
                          'المنزل',
                          fontWeight: FontWeight.bold,
                        ),
                        TextBody12('نور الدين جمال'),
                        TextBody12('مصر - القاهرة - مدينة نصر - ...')
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        padding: EdgeInsets.all(3.sp),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1.5.sp),
                          color: Colors.transparent,
                        ),
                        child: Container(
                          width: 12.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 1.sp),
                              color: Colors.transparent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    right: 16.w, top: 8.h, bottom: 8.h, left: 24.w),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        offset: Offset(1.w, 3.h),
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(14.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.location1),
                    SizedBox(
                      width: 6.w,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 1.h,
                      children: [
                        TextBody14(
                          'العمل',
                          fontWeight: FontWeight.bold,
                        ),
                        TextBody12('نور الدين جمال'),
                        TextBody12('مصر - القليوبية - شبرا - ...')
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        padding: EdgeInsets.all(3.sp),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1),
                          color: Colors.transparent,
                        ),
                        child: Container(
                          width: 12.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 1),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    HexColor('#29F3D1'),
                                    HexColor('#177565'),
                                  ])),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigation.push(context, AddAddressScreen());
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6.w,
                        children: [
                          SvgPicture.asset(AppAssets.add),
                          TextBody14(
                            'اضافة عنوان جديد',
                            color: AppColors.primaryColor,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigation.push(context, AddressScreen());
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6.w,
                        children: [
                          TextBody14(
                            'تعديل العناوين',
                            color: AppColors.primaryColor,
                          ),
                          SvgPicture.asset(
                            AppAssets.edit1,
                            height: 16.h,
                            colorFilter: ColorFilter.mode(
                                AppColors.primaryColor, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              TextTitle('اختر طريقة الدفع', color: AppColors.primaryColor),
              SizedBox(
                height: 12.h,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      right: 16.w, top: 8.h, bottom: 8.h, left: 24.w),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          offset: Offset(1.w, 3.h),
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 6.w,
                    children: [
                      SvgPicture.asset(
                        AppAssets.wallet1,
                        height: 18.h,
                      ),
                      TextBody14(
                        'من رصيد المحفظة',
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 24.w,
                          height: 24.h,
                          padding: EdgeInsets.all(3.sp),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.primaryColor, width: 1.5.sp),
                            color: Colors.transparent,
                          ),
                          child: Container(
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1.sp),
                                color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 8.h,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      right: 16.w, top: 8.h, bottom: 8.h, left: 24.w),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          offset: Offset(1.w, 3.h),
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 6.w,
                    children: [
                      SvgPicture.asset(
                        AppAssets.cod,
                        height: 18.h,
                      ),
                      TextBody14(
                        'كاش عند الإستلام',
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 24.w,
                          height: 24.h,
                          padding: EdgeInsets.all(3.sp),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.primaryColor, width: 1),
                            color: Colors.transparent,
                          ),
                          child: Container(
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      HexColor('#29F3D1'),
                                      HexColor('#177565'),
                                    ])),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 24.h,
              ),
              InkWell(
                onTap: () {
                 // Navigator.pop(context);
                  Navigation.push(context, CheckOutScreen());
                },
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  width: double.infinity,
                  height: 38.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: LinearGradient(colors: [
                        HexColor('#31D3C6'),
                        HexColor('#208B78'),
                      ]),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1.w, 3.h),
                            blurRadius: 6.0,
                            color: AppColors.black.withValues(alpha: 0.15))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 6.w,
                    children: [
                      TextBody14(
                        'استكمال...',
                        color: AppColors.white,
                      ),
                      SvgPicture.asset(
                        AppAssets.arrowLeft,
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              )
            ])),
      ),
    );
  }
}
