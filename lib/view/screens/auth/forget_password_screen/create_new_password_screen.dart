import 'dart:ui';

import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../common_components/custom_button/custom_button.dart';
import '../../../common_components/custom_text_form_field/custom_text_form_field.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              AuthCubit.get(context).clearData();
              Navigator.pop(context);
            },
          )),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SvgPicture.asset(
            AppAssets.background,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 115.h,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppAssets.logo,
                  height: 30.h,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextBody12(
                    'إنشاء كلمة مرور جديدة',
                    textAlign: TextAlign.center,

                    color: AppColors.secondaryColor,
                    //fontFamily: 'Lamar',
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: Form(
                        key: AuthCubit.get(context).createNewPasswordFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const TextTitle('تم التحقق من الكود بنجاح'),
                                SizedBox(
                                  width: 8.w,
                                ),
                                SvgPicture.asset(
                                  AppAssets.done,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            const TextBody14(
                                'من فضلك قم بإنشاء كلمة مرور جديدة'),
                            SizedBox(
                              height: 20.h,
                            ),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return CustomTextFormField(
                                  title: 'كلمة المرور الجديدة',
                                  hint: ' أدخل كلمة المرور',
                                  icon: AppAssets.password,
                                  titleColor: AppColors.black,
                                  isPassword: true,
                                  validator: (value) {
                                    if ((value ?? '').trim().isEmpty) {
                                      return 'الرجاء إدخال كلمة المرور';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  obscureText:
                                      AuthCubit.get(context).showPassword,
                                  controller: AuthCubit.get(context)
                                      .createNewPasswordController,
                                  onIconTap: AuthCubit.get(context)
                                      .changePasswordVisibility,
                                  suffixIcon:
                                      !AuthCubit.get(context).showPassword
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
                            SizedBox(
                              height: 12.h,
                            ),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return CustomTextFormField(
                                  title: 'تأكيد كلمة المرور',
                                  hint: ' أدخل كلمة المرور',
                                  icon: AppAssets.password,
                                  titleColor: AppColors.black,
                                  isPassword: true,
                                  validator: (value) {
                                    if ((value ?? '').trim().isEmpty) {
                                      return 'الرجاء إدخال كلمة المرور';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  obscureText:
                                      AuthCubit.get(context).showPassword,
                                  controller: AuthCubit.get(context)
                                      .confirmPasswordController,
                                  onIconTap: AuthCubit.get(context)
                                      .changePasswordVisibility,
                                  suffixIcon:
                                      !AuthCubit.get(context).showPassword
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
                            SizedBox(
                              height: 24.h,
                            ),
                            CustomButton(
                              onPressed: () {
                                if (AuthCubit.get(context)
                                    .createNewPasswordFormKey
                                    .currentState!
                                    .validate()) {
                                  if (AuthCubit.get(context)
                                          .createNewPasswordController
                                          .text !=
                                      AuthCubit.get(context)
                                          .confirmPasswordController
                                          .text) {
                                    debugPrint('not equal');
                                    showToast('كلمة المرور غير متطابقة',
                                        context: context,
                                        animation: StyledToastAnimation.scale,
                                        reverseAnimation:
                                            StyledToastAnimation.fade,
                                        position: StyledToastPosition.bottom,
                                        animDuration:
                                            const Duration(seconds: 1),
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.elasticOut,
                                        reverseCurve: Curves.linear,
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                        backgroundColor: Colors.red,
                                        isHideKeyboard: true,
                                        textStyle: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Lamar',
                                        ));
                                  } else {
                                    debugPrint('equal');
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor:
                                            AppColors.white.withOpacity(0.65),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 4.0,
                                            sigmaY: 4.0,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 50.h,
                                                horizontal: 40.w),
                                            //EdgeInsets.all(50.sp),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.white,
                                                width: 2.w,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  AppAssets.confirm,
                                                  height: 80.h,
                                                  width: 80.w,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Colors.green,
                                                          BlendMode.srcIn),
                                                ),
                                                SizedBox(height: 24.h),
                                                TextTitle(
                                                  'تم إنشاء كلمة المرور\nبنجاح',
                                                  fontSize: 18.sp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    Future.delayed(const Duration(seconds: 2)).then((value) {
                                      AuthCubit.get(context).clearData();

                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });


                                    /*showToast('كلمة المرور تم تغييرها بنجاح',
                                        context: context,
                                        animation: StyledToastAnimation.scale,
                                        reverseAnimation:
                                            StyledToastAnimation.fade,
                                        position: StyledToastPosition.bottom,
                                        animDuration:
                                            const Duration(seconds: 1),
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.elasticOut,
                                        reverseCurve: Curves.linear,
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                        backgroundColor: Colors.green,
                                        isHideKeyboard: true,
                                        textStyle: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Lamar',
                                        ));*/
                                    // await Duration(seconds: 2).delay();
                                  }
                                }
                              },
                              child: SizedBox(
                                height: 40.h,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const TextTitle('تغيير كلمة المرور'),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    SvgPicture.asset(
                                      AppAssets.done,
                                      height: 20.h,
                                      width: 20.w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
