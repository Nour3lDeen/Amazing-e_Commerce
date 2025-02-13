import 'dart:ui';

import 'package:ecommerce/view/screens/others/address/view_location.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../common_components/custom_button/custom_button.dart';

class LocationComponent extends StatelessWidget {
  const LocationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.push(context, ViewLocation());
      },
      child: Container(
        height: 70.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: AppColors.othersColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: Offset(0.0, 3.h),
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
              spacing: 2.h,
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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AppAssets.edit1, height: 17.h),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              backgroundColor:
                                  AppColors.white.withValues(alpha: 0.65),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 4.0,
                                    sigmaY: 4.0,
                                  ),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16.h, horizontal: 24.w),
                                      //EdgeInsets.all(50.sp),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.white,
                                          width: 2.w,
                                        ),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Column(
                                        spacing: 8.h,
                                          mainAxisSize: MainAxisSize.min,

                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.error_outline_rounded,
                                              color: AppColors.red,
                                              size: 50.sp,
                                            ),
                                            TextBody14(
                                              'سيتم حذف العنوان \nهل انت متأكد؟',
                                              fontSize: 16.sp,
                                              color: AppColors.black,
                                              textAlign: TextAlign.center,
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CustomButton(
                                                  onPressed: () {
                                                    AuthCubit.get(context)
                                                        .viewToast(
                                                            'تم حذف العنوان ',
                                                            context,
                                                            AppColors.red);
                                                    Navigator.pop(context);
                                                  },
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    HexColor(
                                                      '#DA6A6A',
                                                    ),
                                                    HexColor(
                                                      '#B20707',
                                                    )
                                                  ]),
                                                  borderRadius: 8.r,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 4.h),
                                                    child: SizedBox(
                                                      width: 95.w,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextBody12(
                                                            'حذف',
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                          SizedBox(width: 4.w),
                                                          SvgPicture.asset(
                                                            AppAssets.delete,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                CustomButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  backgroundColor:
                                                      AppColors.white,
                                                  child: Container(
                                                    width: 95.w,
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 4.h),
                                                    decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8.r),
                                                        border: Border.all(
                                                            color: AppColors.red,
                                                            width: 1)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextBody12(
                                                          'إلغاء',
                                                          color: AppColors.red,
                                                        ),
                                                        SizedBox(width: 4.w),
                                                        Icon(
                                                          Icons.cancel_outlined,
                                                          color: AppColors.red,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]))));
                        });
                  },
                  child: SvgPicture.asset(
                    AppAssets.delete,
                    colorFilter: ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                    height: 22.h,
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
