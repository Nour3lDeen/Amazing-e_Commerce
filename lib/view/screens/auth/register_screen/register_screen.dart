import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/translation/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../view_model/cubits/auth/auth_cubit.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../common_components/custom_button/custom_button.dart';
import '../../../common_components/custom_text_form_field/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SvgPicture.asset(
            AppAssets.background,
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          //  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          primary: false,
          child: Padding(
            padding: EdgeInsets.only(top: 115.h),
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
                    LocaleKeys.register.tr(),
                    textAlign: TextAlign.center,

                    color: AppColors.secondaryColor,
                    //fontFamily: 'Lamar',
                    fontSize: 18.sp,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        // height: 470.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Form(
                            key: AuthCubit.get(context).registerFormKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: LocaleKeys.firstName.tr(),
                                        hint: LocaleKeys.firstName.tr(),
                                        icon: AppAssets.profile,
                                        titleColor: AppColors.black,
                                        isPassword: false,
                                        controller: AuthCubit.get(context)
                                            .registerFirstNameController,
                                        onIconTap: () {},
                                        suffixIcon: const Icon(Icons.email),
                                        obscureText: false,
                                        validator: (value) {
                                          if ((value ?? '').trim().isEmpty) {
                                            return LocaleKeys.firstNameError
                                                .tr();
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: LocaleKeys.lastName.tr(),
                                        hint: LocaleKeys.lastName.tr(),
                                        icon: AppAssets.family,
                                        titleColor: AppColors.black,
                                        isPassword: false,
                                        controller: AuthCubit.get(context)
                                            .registerSecondNameController,
                                        onIconTap: () {},
                                        suffixIcon: const Icon(Icons.email),
                                        obscureText: false,
                                        validator: (value) {
                                          if ((value ?? '').trim().isEmpty) {
                                            return LocaleKeys.lastNameError
                                                .tr();
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                CustomTextFormField(
                                  title: LocaleKeys.email.tr(),
                                  hint: LocaleKeys.emailHint.tr(),
                                  icon: AppAssets.email,
                                  titleColor: AppColors.black,
                                  isPassword: false,
                                  controller: AuthCubit.get(context)
                                      .registerEmailController,
                                  onIconTap: () {},
                                  suffixIcon: const Icon(Icons.email),
                                  obscureText: false,
                                  validator: (value) {
                                    if ((value ?? '').trim().isEmpty) {
                                      return LocaleKeys.emailError.tr();
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                CustomTextFormField(
                                  title: LocaleKeys.phoneNumber.tr(),
                                  hint: LocaleKeys.phoneNumberHint.tr(),
                                  icon: AppAssets.call,
                                  titleColor: AppColors.black,
                                  isPassword: false,
                                  controller: AuthCubit.get(context)
                                      .registerNumberController,
                                  onIconTap: () {},
                                  suffixIcon: const Icon(Icons.email),
                                  obscureText: false,
                                  validator: (value) {
                                    if ((value ?? '').trim().isEmpty) {
                                      return LocaleKeys.phoneNumberError.tr();
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                /*
                                Row(
                                  children: [
                                    Expanded(
                                      child: BlocBuilder<AuthCubit, AuthState>(
                                        builder: (context, state) {
                                          final cubit = AuthCubit.get(context);
                                          return CustomDropdownFormField(
                                            title: LocaleKeys.gender.tr(),
                                            icon: AppAssets.gender,
                                            titleColor: AppColors.black,
                                            hint: LocaleKeys.genderHint.tr(),
                                            items: cubit.genders,
                                            value: cubit.selectedGender,
                                            onChanged: (value) {
                                              cubit.changeGender(value);
                                            },
                                            validator: (value) {
                                              if ((value ?? '').trim().isEmpty) {
                                                return LocaleKeys.genderError.tr();
                                              }
                                              return null;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: CustomTextFormField(
                                        readOnly: true,
                                        // Makes the field read-only
                                        title: LocaleKeys.birthDate.tr(),
                                        hint: LocaleKeys.birthDateHint.tr(),
                                        icon: AppAssets.date,
                                        titleColor: AppColors.black,
                                        isPassword: false,
                                        controller: AuthCubit.get(context)
                                            .registerDateController,
                                        // Use a dedicated controller
                                        onTap: () async {
                                          DateTime? selectedDate =
                                              await showDatePicker(
                                            barrierLabel: LocaleKeys.chooseDate.tr(),
                                            cancelText: LocaleKeys.close.tr(),
                                            helpText: LocaleKeys.chooseDate.tr(),
                                            confirmText: LocaleKeys.confirm.tr(),
                                            initialEntryMode:
                                                DatePickerEntryMode.calendarOnly,

                                            context: context,
                                            initialDate: AuthCubit.get(context)
                                                    .registerDateController
                                                    .text
                                                    .isNotEmpty
                                                ? DateTime.parse(
                                                    AuthCubit.get(context)
                                                        .registerDateController
                                                        .text)
                                                : DateTime.now(),
                                            // Default initial date
                                            firstDate: DateTime(1900),
                                            // Earliest selectable date
                                            lastDate: DateTime.now(),
                                            // Latest selectable date
                                            builder: (context, child) {
                                              return Theme(
                                                data: Theme.of(context).copyWith(
                                                  colorScheme: ColorScheme.light(
                                                    primary:
                                                        AppColors.primaryColor,
                                                    // Customize the primary color
                                                    onPrimary: Colors.white,
                                                    // Text color on primary
                                                    onSurface: AppColors
                                                        .black, // Text color on surface
                                                  ),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: AppColors
                                                          .primaryColor, // Button color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );

                                          // Update the Cubit with the selected date
                                          if (selectedDate != null) {
                                            AuthCubit.get(context)
                                                .updateBirthDate(selectedDate);
                                          }
                                        },
                                        onIconTap: () {},
                                        suffixIcon:
                                            const Icon(Icons.calendar_today),
                                        // Calendar icon
                                        obscureText: false,
                                        validator: (value) {
                                          if ((value ?? '').trim().isEmpty) {
                                            return LocaleKeys.birthDateError.tr();
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                      */
                                /* SizedBox(
                                  height: 6.h,
                                ),*/
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
                                      textInputAction: TextInputAction.done,
                                      obscureText:
                                          AuthCubit.get(context).showPassword,
                                      controller: AuthCubit.get(context)
                                          .registerPasswordController,
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
                                SizedBox(
                                  height: 24.h,
                                ),
                                BlocConsumer<AuthCubit, AuthState>(
                                  listener: (context, state) {
                                    if (state is RegisterSuccessState) {
                                      AuthCubit.get(context).viewToast(
                                          LocaleKeys.registerSuccess.tr(),
                                          context,
                                          Colors.green);
                                    } else if (state is RegisterErrorState) {
                                      AuthCubit.get(context).viewToast(
                                          state.msg, context, Colors.red);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is RegisterLoadingState) {
                                      return LoadingAnimationWidget.inkDrop(
                                          color: AppColors.primaryColor,
                                          size: 15.sp);
                                    }
                                    return CustomButton(
                                      onPressed: () {
                                        if (AuthCubit.get(context)
                                            .registerFormKey
                                            .currentState!
                                            .validate()) {
                                          if (!AuthCubit.get(context)
                                              .validateEmail(
                                                  AuthCubit.get(context)
                                                      .registerEmailController
                                                      .text)) {
                                            showToast(
                                                LocaleKeys.emailError.tr(),
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
                                          } else {
                                            AuthCubit.get(context).register();
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
                                              LocaleKeys.register.tr(),
                                              color: AppColors.black,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
