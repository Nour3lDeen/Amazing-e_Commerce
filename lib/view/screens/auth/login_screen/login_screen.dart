import 'package:ecommerce/view/screens/auth/forget_password_screen/forget_password_screen.dart';
import 'package:ecommerce/view/screens/auth/register_screen/register_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../common_components/custom_button/custom_button.dart';
import '../../../common_components/custom_text_form_field/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
            child: SingleChildScrollView(
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
                      'تسجيل الدخول',
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
                          key: AuthCubit.get(context).loginFormKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                title: 'البريد الإلكتروني',
                                hint: 'أدخل البريد الإلكتروني',
                                icon: AppAssets.email,
                                titleColor: AppColors.black,
                                isPassword: false,
                                controller:
                                    AuthCubit.get(context).loginEmailController,
                                textInputAction: TextInputAction.next,
                                onIconTap: () {},
                                suffixIcon: const Icon(Icons.email),
                                obscureText: false,
                                validator: (value) {
                                  if ((value ?? '').trim().isEmpty) {
                                    return 'الرجاء إدخال البريد الإلكتروني';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  return CustomTextFormField(
                                    title: 'كلمة المرور',
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
                                        .loginPasswordController,
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6.h,
                                ),
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BlocBuilder<AuthCubit, AuthState>(
                                      builder: (context, state) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: SizedBox(
                                            width: 16.w,
                                            child: Checkbox(
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                value: AuthCubit.get(context)
                                                    .rememberMe,
                                                onChanged: (value) {
                                                  AuthCubit.get(context)
                                                      .changeRememberMe();
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4.r),
                                                ),
                                                activeColor:
                                                    AppColors.primaryColor,
                                                checkColor: AppColors.white,
                                                side: BorderSide(
                                                  color: AppColors.black
                                                      .withOpacity(0.6),
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    TextBody12(
                                      'تذكرني',
                                      color: AppColors.black.withOpacity(0.6),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        Navigation.push(context,
                                            const ForgetPasswordScreen());
                                        AuthCubit.get(context).clearData();
                                      },
                                      style: const ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: TextBody12(
                                        'نسيت كلمة المرور؟',
                                        color: AppColors.black.withOpacity(0.6),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              BlocConsumer<AuthCubit, AuthState>(
                                listener: (context, state) {
                                  if (state is LoginSuccessState) {
                                    AuthCubit.get(context).viewToast(
                                        'تم تسجيل الدخول', context, Colors.green);
                                  } else if (state is LoginErrorState) {
                                    AuthCubit.get(context).viewToast(
                                        state.msg, context, Colors.red);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoginLoadingState) {
                                    return const CircularProgressIndicator.adaptive();
                                  }
                                  return CustomButton(
                                    onPressed: () {
                                      if (AuthCubit.get(context)
                                          .loginFormKey
                                          .currentState!
                                          .validate()) {
                                        if (!AuthCubit.get(context).validateEmail(
                                            AuthCubit.get(context)
                                                .loginEmailController
                                                .text)) {
                                          showToast('البريد الإلكتروني غير صحيح',
                                              context: context,
                                              animation:
                                                  StyledToastAnimation.scale,
                                              reverseAnimation:
                                                  StyledToastAnimation.fade,
                                              position:
                                                  StyledToastPosition.bottom,
                                              animDuration:
                                                  const Duration(seconds: 1),
                                              duration:
                                                  const Duration(seconds: 2),
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
                                        }
                                        else{
                                          AuthCubit.get(context).login();
                                        }
                                      }
                                    },
                                    borderRadius: 14.r,
                                    child: SizedBox(
                                      height: 40.h,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Center(
                                          child: TextTitle(
                                            'تسجيل الدخول',
                                            color: AppColors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const TextBody14(
                                    'ليس لديك حساب؟',
                                  ),
                                  TextButton(
                                    style: const ButtonStyle(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      Navigation.push(
                                          context, const RegisterScreen());
              
                                      AuthCubit.get(context).clearData();
                                      //AuthCubit.get(context).showPassword = false;
                                      debugPrint(
                                          '${AuthCubit.get(context).showPassword}');
                                    },
                                    child: TextTitle(
                                      fontSize: 14.sp,
                                      'إنشاء حساب جديد',
                                      color: AppColors.secondaryColor,
                                    ),
                                  )
                                ],
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
      ),
    );
  }
}
