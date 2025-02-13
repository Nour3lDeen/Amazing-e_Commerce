import 'dart:ui';

import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../common_components/custom_button/custom_button.dart';
import '../../../common_components/custom_text_form_field/custom_text_form_field.dart';
import 'otp_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              /*Navigation.pushAndRemove(context, const LoginScreen());*/
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
                    'نسيت كلمة المرور',
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha:0.35),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Form(
                            key: AuthCubit.get(context).forgetPasswordFormKey,
                            child: Column(
                              children: [
                                TextBody14(
                                    fontSize: 14.sp,
                                    'قم بإدخل البريد الإلكتروني الخاص بالحساب وسيتم إرسال رمز مكون من 5 أرقام لتأكيد عملية الدخول.'),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomTextFormField(
                                  title: 'البريد الإلكتروني',
                                  hint: 'أدخل البريد الإلكتروني',
                                  icon: AppAssets.email,
                                  titleColor: AppColors.black,
                                  isPassword: false,
                                  controller: AuthCubit.get(context)
                                      .forgetPasswordEmailController,
                                  onIconTap: () {},
                                  suffixIcon: const Icon(Icons.email),
                                  obscureText: false,
                                  validator: (value) {
                                    if ((value ?? '').trim().isEmpty) {
                                      return 'الرجاء إدخال البريد الإلكتروني';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    if (AuthCubit.get(context)
                                        .forgetPasswordFormKey
                                        .currentState!
                                        .validate()) {
                                      if (!AuthCubit.get(context).validateEmail(
                                          AuthCubit.get(context)
                                              .forgetPasswordEmailController
                                              .text)) {
                                        showToast('البريد الإلكتروني غير صحيح',
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
                                        Navigation.push(context, const OtpScreen());
                                      }
                                    }
                                  },
                                  borderRadius: 14.r,
                                  child: SizedBox(
                                    height: 40.h,
                                    width: double.infinity,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextTitle(
                                            'إرسال الرمز',
                                            color: AppColors.black,
                                            fontSize: 16.sp,
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          SvgPicture.asset(
                                            AppAssets.send,
                                            height: 20.h,
                                            width: 20.w,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
