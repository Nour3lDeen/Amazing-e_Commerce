import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/translation/locale_keys.g.dart';
import 'package:ecommerce/view/common_components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

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
            width: double.infinity,
            padding: EdgeInsets.only(
                right: 16.w, left: 16.w, bottom: 32.h, top: 32.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
              color: AppColors.white.withValues(alpha: 0.75),
              border: Border.all(color: AppColors.white, width: 2.sp),
            ),
            child: Column(
                spacing: 12.h,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        title: 'كلمة المرور الحالية',
                        hint: LocaleKeys.passwordHint.tr(),
                        icon: AppAssets.password,
                        fillColor: AppColors.white,
                        titleColor: AppColors.black,
                        isPassword: true,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return LocaleKeys.passwordError.tr();
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        obscureText: AuthCubit.get(context).showPassword,
                        controller:
                            AuthCubit.get(context).registerPasswordController,
                        onIconTap:
                            AuthCubit.get(context).changePasswordVisibility,
                        suffixIcon: !AuthCubit.get(context).showPassword
                            ? Icon(
                                Icons.visibility,
                                color: AppColors.grey,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                        keyboardType: TextInputType.visiblePassword,
                      );
                    },
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        fillColor: AppColors.white,
                        title: 'كلمة المرور الجديدة',
                        hint: LocaleKeys.passwordHint.tr(),
                        icon: AppAssets.password,
                        titleColor: AppColors.black,
                        isPassword: true,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return LocaleKeys.passwordError.tr();
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        obscureText: AuthCubit.get(context).showPassword,
                        controller:
                            AuthCubit.get(context).registerPasswordController,
                        onIconTap:
                            AuthCubit.get(context).changePasswordVisibility,
                        suffixIcon: !AuthCubit.get(context).showPassword
                            ? Icon(
                                Icons.visibility,
                                color: AppColors.grey,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                        keyboardType: TextInputType.visiblePassword,
                      );
                    },
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        fillColor: AppColors.white,
                        title: 'تأكيد كلمة المرور',
                        hint: 'أعد كتابة كلمة المرور',
                        icon: AppAssets.password,
                        titleColor: AppColors.black,
                        isPassword: true,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return LocaleKeys.passwordError.tr();
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        obscureText: AuthCubit.get(context).showPassword,
                        controller:
                            AuthCubit.get(context).registerPasswordController,
                        onIconTap:
                            AuthCubit.get(context).changePasswordVisibility,
                        suffixIcon: !AuthCubit.get(context).showPassword
                            ? Icon(
                                Icons.visibility,
                                color: AppColors.grey,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                        keyboardType: TextInputType.visiblePassword,
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  InkWell(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                       // barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) => Dialog(
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
                                  vertical: 30.h, horizontal: 40.w),
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
                                  SvgPicture.asset(
                                    AppAssets.confirm,
                                    height: 80.h,
                                    width: 80.w,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.green, BlendMode.srcIn),
                                  ),
                                  SizedBox(height: 24.h),
                                  TextTitle(
                                    'تم تعديل كلمة المرور\nبنجاح',
                                    fontSize: 18.sp,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 2)).then(
                        (value) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(14.r),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          gradient: LinearGradient(colors: [
                            HexColor('#31D3C6'),
                            HexColor('#208B78'),
                          ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: Offset(0.0, 3.h),
                              blurRadius: 6.0,
                            )
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 6.w,
                          children: [
                            TextBody14('تحديث كلمة المرور',
                                color: AppColors.white),
                            SvgPicture.asset(
                              AppAssets.right,
                              height: 16.h,
                              colorFilter: ColorFilter.mode(
                                  AppColors.white, BlendMode.srcIn),
                            )
                          ]),
                    ),
                  )
                ])),
      ),
    );
  }
}
