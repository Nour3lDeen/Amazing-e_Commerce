import 'dart:ui';

import 'package:ecommerce/view/screens/auth/login_screen/login_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';

class ConfirmEmailScreen extends StatelessWidget {
  const ConfirmEmailScreen({super.key});

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
              children: [
                SvgPicture.asset(
                  AppAssets.blackLogo,
                  height: 40.h,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Align(
                  child: TextBody12(
                    'تأكيد البريد الإلكتروني',
                    textAlign: TextAlign.center,
                    color: AppColors.secondaryColor,
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
                          color: AppColors.white.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextTitle('التحقق من الكود'),
                              SizedBox(
                                height: 12.h,
                              ),
                              const TextBody14(
                                  'قم بكتابة الكود المرسل إليك علي البريد الإلكتروني.'),
                              SizedBox(
                                height: 20.h,
                              ),
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  return Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: OtpTextField(
                                      numberOfFields: 6,
                                      borderColor: AppColors.primaryColor,
                                      //borderWidth: 0,
                                      borderRadius: BorderRadius.circular(8.r),
                                      showFieldAsBox: true,
                                      //enabledBorderColor: AppColors.primaryColor,
                                      focusedBorderColor:
                                          AppColors.secondaryColor,
                                      fillColor: AppColors.white
                                          .withValues(alpha: 0.65),
                                      filled: true,
                                      clearText: AuthCubit.get(context)
                                          .otpController
                                          .text
                                          .isEmpty,
                                      cursorColor: AppColors.secondaryColor,
                                      fieldWidth: 40.w,
                                      fieldHeight: 40.h,
                                      onSubmit: (String verificationCode) {
                                        // do something with the code

                                        AuthCubit.get(context)
                                            .otpController
                                            .text = verificationCode;
                                        debugPrint(
                                            'OTP1: ${AuthCubit.get(context).otpController.text}');
                                        AuthCubit.get(context).sendOtp(context);
                                        debugPrint(state.toString());
                                        if (state is ResendOtpSuccessState) {
                                          Navigation.pushReplacement(
                                              context, const LoginScreen());
                                        }

                                        /// todo request code
                                      },
                                      onCodeChanged: (String code) {
                                        AuthCubit.get(context)
                                            .otpController
                                            .text = code;
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                children: [
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, state) {
                                      final cubit = AuthCubit.get(context);
                                      final hours = (cubit.otpTimer ~/ 3600)
                                          .toString()
                                          .padLeft(2, '0');
                                      final minutes =
                                          ((cubit.otpTimer % 3600) ~/ 60)
                                              .toString()
                                              .padLeft(2, '0');
                                      final seconds = (cubit.otpTimer % 60)
                                          .toString()
                                          .padLeft(2, '0');

                                      return Column(
                                        children: [
                                          const TextBody12('الوقت المتبقي '),
                                          TextBody12(
                                              '$hours:$minutes:$seconds'),
                                          // Display formatted time
                                        ],
                                      );
                                    },
                                  ),
                                  const Spacer(),
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, state) {
                                      final cubit = AuthCubit.get(context);
                                      if (state is ResendOtpLoadingState) {
                                        return LoadingAnimationWidget.inkDrop(
                                            color: AppColors.primaryColor,
                                            size: 15.sp);
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            if (cubit.canResendOtp) {
                                              cubit.resendOtp(context);
                                            }
                                          },
                                          child: TextBody14(
                                            'إعادة إرسال\n الكود',
                                            color: cubit.canResendOtp
                                                ? AppColors.primaryColor
                                                : AppColors.grey,
                                            shadows: [
                                              if (cubit.canResendOtp)
                                                BoxShadow(
                                                  color: AppColors.black
                                                      .withValues(alpha: 0.2),
                                                  blurRadius: 5,
                                                  offset: Offset(1.w, 1.h),
                                                )
                                            ],
                                            fontSize: 12.sp,
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      } // Hide button when timer is running
                                    },
                                  ),
                                ],
                              )
                            ],
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
