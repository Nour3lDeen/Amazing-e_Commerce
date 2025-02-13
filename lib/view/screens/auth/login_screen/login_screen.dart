import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/translation/locale_keys.g.dart';
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
    return Scaffold(
      appBar: AppBar(
        clipBehavior: Clip.none,
        forceMaterialTransparency: true,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        /*actions:  [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:8.w),
            child: IconButton(
                onPressed: (){
                  if(context.locale==const Locale('en')) {
                    context.setLocale(const Locale('ar'));
                  }else{
                    context.setLocale(const Locale('en'));
                  }
                },
                icon: Icon(Icons.language_outlined,color: AppColors.black,)),
          ),
        ],*/
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
          ),
        ),
      ),
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
                  child: Hero(
                    tag: 'login',
                    transitionOnUserGestures: true,
                    child: Material(
                      color: Colors.transparent,
                      child: TextTitle(
                        LocaleKeys.login.tr(),
                        textAlign: TextAlign.center,

                        color: AppColors.secondaryColor,
                        //fontFamily: 'Lamar',
                        fontSize: 18.sp,
                      ),
                    ),
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
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Form(
                            key: AuthCubit.get(context).loginFormKey,
                            child: Column(
                              spacing: 6.h,
                              children: [
                                CustomTextFormField(
                                  title: LocaleKeys.email.tr(),
                                  hint: LocaleKeys.emailHint.tr(),
                                  icon: AppAssets.email,
                                  titleColor: AppColors.black,
                                  isPassword: false,
                                  controller: AuthCubit.get(context)
                                      .loginEmailController,
                                  textInputAction: TextInputAction.next,
                                  onIconTap: () {},
                                  suffixIcon: const Icon(Icons.email),
                                  obscureText: false,
                                  validator: (value) {
                                    if ((value ?? '').trim().isEmpty) {
                                      return LocaleKeys.emailError.tr();
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    return CustomTextFormField(
                                      title: LocaleKeys.password.tr(),
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
                                      onSubmitted: (value) {
                                        AuthCubit.get(context).login();
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    );
                                  },
                                ),
                                Row(
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
                                                      BorderRadius.circular(
                                                          4.r),
                                                ),
                                                activeColor:
                                                    AppColors.primaryColor,
                                                checkColor: AppColors.white,
                                                side: BorderSide(
                                                  color: AppColors.black
                                                      .withValues(alpha: 0.6),
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    TextBody12(
                                      LocaleKeys.rememberMe.tr(),
                                      color: AppColors.black
                                          .withValues(alpha: 0.6),
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
                                        LocaleKeys.forgotPassword.tr(),
                                        color: AppColors.black
                                            .withValues(alpha: 0.6),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 12.h),
                                  child: BlocConsumer<AuthCubit, AuthState>(
                                    listener: (context, state) {
                                      if (state is LoginSuccessState) {
                                        Navigator.pop(context);
                                        AuthCubit.get(context).viewToast(
                                            LocaleKeys.loginSuccess.tr(),
                                            context,
                                            Colors.green);
                                      } else if (state is LoginErrorState) {
                                        AuthCubit.get(context).viewToast(
                                            state.msg, context, Colors.red);
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is LoginLoadingState) {
                                        return const CircularProgressIndicator
                                            .adaptive();
                                      }
                                      return CustomButton(
                                        onPressed: () {
                                          if (AuthCubit.get(context)
                                              .loginFormKey
                                              .currentState!
                                              .validate()) {
                                            if (!AuthCubit.get(context)
                                                .validateEmail(
                                                    AuthCubit.get(context)
                                                        .loginEmailController
                                                        .text)) {
                                              showToast(
                                                  LocaleKeys.emailNotCorrect
                                                      .tr(),
                                                  context: context,
                                                  animation:
                                                      StyledToastAnimation
                                                          .scale,
                                                  reverseAnimation:
                                                      StyledToastAnimation.fade,
                                                  position: StyledToastPosition
                                                      .bottom,
                                                  animDuration: const Duration(
                                                      seconds: 1),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  curve: Curves.elasticOut,
                                                  reverseCurve: Curves.linear,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.r),
                                                  backgroundColor: Colors.red,
                                                  isHideKeyboard: true,
                                                  textStyle: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 12.sp,
                                                    fontFamily: 'Lamar',
                                                  ));
                                            } else {
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
                                                LocaleKeys.login.tr(),
                                                color: AppColors.black,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextBody14(
                                      LocaleKeys.doNotHaveAnAccount.tr(),
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
                                        debugPrint(
                                            '${AuthCubit.get(context).showPassword}');
                                      },
                                      child: TextTitle(
                                        fontSize: 14.sp,
                                        LocaleKeys.register.tr(),
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
