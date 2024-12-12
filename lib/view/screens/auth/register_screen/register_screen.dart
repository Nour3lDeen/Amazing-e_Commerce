import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../view_model/cubits/auth/auth_cubit.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../common_components/custom_button/custom_button.dart';
import '../../../common_components/custom_drop_down/custom_drop_down.dart';
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              AuthCubit.get(context).clearData();
              Navigator.pop(context);
            },
          )),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(children: [
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
                      'إنشاء حساب جديد',
                      textAlign: TextAlign.center,

                      color: AppColors.secondaryColor,
                      //fontFamily: 'Lamar',
                      fontSize: 18.sp,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
                    child: Container(
                      // height: 470.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.45),
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
                                      title: 'الإسم الأول',
                                      hint: 'الإسم الأول',
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
                                          return 'الرجاء إدخال الإسم الأول';
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
                                      title: 'إسم العائلة',
                                      hint: 'إسم العائلة',
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
                                          return 'الرجاء إدخال إسم العائلة';
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
                                title: 'البريد الإلكتروني',
                                hint: 'أدخل البريد الإلكتروني',
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
                                    return 'الرجاء إدخال البريد الإلكتروني';
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
                                title: 'رقم الجوال',
                                hint: 'أدخل رقم الجوال',
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
                                    return 'الرجاء إدخال رقم الجوال';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: BlocBuilder<AuthCubit, AuthState>(
                                      builder: (context, state) {
                                        final cubit = AuthCubit.get(context);
                                        return CustomDropdownFormField(
                                          title: 'النوع',
                                          icon: AppAssets.gender,
                                          titleColor: AppColors.black,
                                          hint: 'أدخل النوع',
                                          items: cubit.genders,
                                          value: cubit.selectedGender,
                                          onChanged: (value) {
                                            cubit.changeGender(value);
                                          },
                                          validator: (value) {
                                            if ((value ?? '').trim().isEmpty) {
                                              return 'الرجاء إدخال النوع';
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
                                      title: 'تاريخ الميلاد',
                                      hint: 'أدخل تاريخ الميلاد',
                                      icon: AppAssets.date,
                                      titleColor: AppColors.black,
                                      isPassword: false,
                                      controller: AuthCubit.get(context)
                                          .registerDateController,
                                      // Use a dedicated controller
                                      onTap: () async {
                                        DateTime? selectedDate =
                                            await showDatePicker(
                                          barrierLabel: 'اختر تاريخ الميلاد',
                                          cancelText: 'إغلاق',
                                          helpText: 'اختر تاريخ الميلاد',
                                          confirmText: 'تأكيد',
                                          initialEntryMode:
                                              DatePickerEntryMode.calendarOnly,

                                          textDirection: TextDirection.rtl,
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
                                          return 'الرجاء إدخال تاريخ الميلاد';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
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
                                    keyboardType: TextInputType.visiblePassword,
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
                                        'تم إنشاء حسابك بنجاح',
                                        context,
                                        Colors.green);
                                  } else if (state is RegisterErrorState) {
                                    AuthCubit.get(context).viewToast(
                                        state.msg, context, Colors.red);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is RegisterLoadingState) {
                                    return const CircularProgressIndicator.adaptive();
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
                                              'البريد الإلكتروني غير صحيح',
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
                                            'إنشاء حساب',
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
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
