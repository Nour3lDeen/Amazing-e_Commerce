import 'dart:ui';

import 'package:ecommerce/view/screens/categories/components/counter_component/counter_component.dart';
import 'package:ecommerce/view/screens/others/refund_requests/refund_details_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class RefundComponent extends StatelessWidget {
  const RefundComponent({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.refund),
              SizedBox(height: 6.h),
              TextBody14('فقط ولأول مرة مع'),
              GradientText(
                'Amazing',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    offset: Offset(1.w, 3.h),
                    blurRadius: 6.0,
                  ),
                ],
                gradient: LinearGradient(
                    colors: [HexColor('#FFF127'), HexColor('#B0A504')]),
              ),
              SizedBox(height: 6.h),
              TextBody14(
                'يمكنك استرجاع (منتجك - رصيدك) في اي وقت من خلال سياسة الاسترجاع المميزة التي نوفرها لعملائنا.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
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
                                  sigmaX: 6.0,
                                  sigmaY: 6.0,
                                ),
                                child: Container(
                                  width: 300.w,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 24.h, horizontal: 20.w),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    spacing: 6.h,
                                    children: [
                                      TextTitle(
                                        'استرجاع رصيد المنتج',
                                        color: AppColors.primaryColor,
                                        fontSize: 20.sp,
                                      ),
                                      TextBody14(
                                        'انت تقوم باسترجاع منتجك مقابل 50% من قيمة المنتج تسترد الي رصيد محفظتك يمكنك استخدامة في عملية الشراء القادمة',
                                        textAlign: TextAlign.center,
                                      ),
                                      TextBody14(
                                        'عدد القطع المسترجعه؟',
                                        textAlign: TextAlign.center,
                                      ),
                                      CounterComponent(
                                          productId: 1,
                                          cart: false,
                                          productCount: 1),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              onTap: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                AuthCubit.get(context)
                                                    .viewToast(
                                                        'تم إرسال الطلب بنجاح',
                                                        context,
                                                        Colors.green);
                                              },
                                              child: Container(
                                                width: 110.w,
                                                height: 30.h,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      HexColor('#2BC339'),
                                                      HexColor('#049312'),
                                                    ],
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                              alpha: 0.15),
                                                      offset: Offset(1.w, 3.h),
                                                      blurRadius: 6.0,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                child: Row(
                                                  spacing: 6.w,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextBody12(
                                                      'تأكيد',
                                                      color: AppColors.white,
                                                    ),
                                                    SvgPicture.asset(
                                                      AppAssets.right,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              AppColors.white,
                                                              BlendMode.srcIn),
                                                      height: 16.h,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: 110.w,
                                                height: 30.h,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      HexColor('#31D3C6'),
                                                      HexColor('#208B78'),
                                                    ],
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                              alpha: 0.15),
                                                      offset: Offset(1.w, 3.h),
                                                      blurRadius: 6.0,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  spacing: 6.w,
                                                  children: [
                                                    TextBody12(
                                                      'إلغاء',
                                                      color: AppColors.white,
                                                    ),
                                                    SvgPicture.asset(
                                                        AppAssets.cancel,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                AppColors.white,
                                                                BlendMode
                                                                    .srcIn))
                                                  ],
                                                ),
                                              ),
                                            )
                                          ])
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: 110.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            HexColor('#2BC339'),
                            HexColor('#049312'),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            offset: Offset(1.w, 3.h),
                            blurRadius: 6.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TextBody12(
                        'استرجاع الرصيد',
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      Navigator.pop(context);
                      Navigation.push(context, const RefundDetailsScreen(fromCart: true,));
                    },
                    child: Container(
                      width: 110.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            HexColor('#31D3C6'),
                            HexColor('#208B78'),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            offset: Offset(1.w, 3.h),
                            blurRadius: 6.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 6.w,
                        children: [
                          TextBody12(
                            'استرجاع المنتج',
                            color: AppColors.white,
                          ),
                          SvgPicture.asset(
                            AppAssets.tShirt,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
