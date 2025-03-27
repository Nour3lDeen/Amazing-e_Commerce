import 'dart:ui';

import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../../common_components/custom_button/custom_button.dart';

class LogoutComponent extends StatelessWidget {
  const LogoutComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
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
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
              color: AppColors.white.withValues(alpha: 0.75),
              border: Border.all(color: AppColors.white, width: 2.sp),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const TextTitle(
                'هل تود الخروج من\nAmazing؟',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.h,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLogoutLoadingState) {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: AppColors.primaryColor, size: 15.sp),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                            onPressed: () {
                              AuthCubit.get(context).logout(context);
                            },
                            borderRadius: 8.r,
                            gradient: LinearGradient(colors: [
                              HexColor('#DA6A6A'),
                              HexColor('#B20707'),
                            ]),
                            child: SizedBox(
                              width: 120.w,
                              height: 30.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextBody14(
                                    'خروج',
                                    color: AppColors.white,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  SvgPicture.asset(AppAssets.logout)
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 16.w,
                        ),
                        CustomButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            borderRadius: 8.r,
                            backgroundColor: AppColors.white,
                            child: Container(
                              width: 120.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.white,
                                border: Border.all(
                                    color: AppColors.red, width: 1.sp),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextBody14(
                                    'إلغاء',
                                    color: AppColors.red,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Icon(
                                    Icons.cancel_outlined,
                                    color: AppColors.red,
                                  )
                                ],
                              ),
                            ))
                      ],
                    );
                  }
                },
              )
            ])),
      ),
    );
  }
}
