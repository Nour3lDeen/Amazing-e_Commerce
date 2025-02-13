import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/translation/locale_keys.g.dart';
import 'package:ecommerce/view/common_components/custom_drop_down/custom_drop_down.dart';
import 'package:ecommerce/view/common_components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // final authCubit = AuthCubit.get(context);
        bool isLoggedIn = SharedHelper.getData(SharedKeys.token) != null;
        return Scaffold(
            body: Stack(
          children: [
            PositionedDirectional(
              start: 0,
              top: 0.h,
              end: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical:
                        SharedHelper.getData(SharedKeys.platform) == 'android'
                            ? 32.h
                            : 48.h),
                width: double.infinity,
                height: 240.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: Image.asset(AppAssets.othersBack).image,
                  fit: BoxFit.cover,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    offset: Offset(0.0, 1.h),
                                    blurRadius: 15,
                                    spreadRadius: 1),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.backIcon1,
                              height: 30.h,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 78.w,
                        ),
                        GradientText(
                          'تحديث البيانات',
                          gradient: LinearGradient(
                            colors: [
                              HexColor('#DCCF0F'),
                              HexColor('#8B8309'),
                            ],
                          ),
                          fontSize: 18.sp,
                        ),

                      ],
                    ),
                    Hero(
                      tag: 'avatar',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.secondaryColor,
                            width: 2.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: Offset(0.0, 3.h),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 35.r,
                          child: isLoggedIn
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        SharedHelper.getData(SharedKeys.avatar)
                                            .replaceFirst(
                                                'http://', 'https://'),
                                    height: 70.h,
                                    width: 70.w,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.asset(
                                  AppAssets.avatar,
                                  height: 70.h,
                                  width: 70.w,
                                  fit: BoxFit.cover,
                                )),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4.w,
                      children: [
                        TextBody14(
                          'تغيير الصورة',
                          color: AppColors.black,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: Offset(0.0, 3.h),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          AppAssets.image,
                          height: 14.h,
                          width: 14.w,
                          colorFilter: ColorFilter.mode(
                              AppColors.black, BlendMode.srcIn),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              start: 0,
              top: 170.h,
              bottom: 0,
              end: 0,
              child: ClipRRect(
                // clipBehavior:Clip.none,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r)),
                      color: AppColors.white.withValues(alpha: 0.6),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.asset(
                          AppAssets.customBack,
                          height: double.infinity,
                          width: double.infinity,
                        ).image,
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12.h,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  title: LocaleKeys.firstName.tr(),
                                  hint: SharedHelper.getData(SharedKeys.firstName),
                                  icon: AppAssets.profile,
                                  titleColor: AppColors.black,
                                  isPassword: false,
                                  borderRadius: 14.r,
                                  fillColor: HexColor('#DADADA'),
                                  hintColor:AppColors.black,
                                  controller: AuthCubit.get(context)
                                      .registerFirstNameController,
                                  onIconTap: () {},
                                  suffixIcon: const Icon(Icons.email),
                                  obscureText: false,
                                  validator: (value) {
                                    if ((value ?? '').trim().isEmpty) {
                                      return LocaleKeys.firstNameError.tr();
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
                                  hint: SharedHelper.getData(SharedKeys.secondName),
                                  icon: AppAssets.family,
                                  titleColor: AppColors.black,
                                  fillColor: HexColor('#DADADA'),
                                  hintColor:AppColors.black,

                                  borderRadius: 14.r,
                                  isPassword: false,
                                  controller: AuthCubit.get(context)
                                      .registerSecondNameController,
                                  onIconTap: () {},
                                  suffixIcon: const Icon(Icons.email),
                                  obscureText: false,
                                  validator: (value) {
                                    if ((value ?? '').trim().isEmpty) {
                                      return LocaleKeys.lastNameError.tr();
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ],
                          ),
                          CustomTextFormField(
                            title: LocaleKeys.email.tr(),
                            hint: 'noor@1.com',
                            icon: AppAssets.email,
                            titleColor: AppColors.black,
                            isPassword: false,
                            hintColor:AppColors.black,

                            controller:
                                AuthCubit.get(context).registerEmailController,
                            onIconTap: () {},
                            fillColor: HexColor('#DADADA'),
                            borderRadius: 14.r,
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
                          CustomTextFormField(
                            title: LocaleKeys.phoneNumber.tr(),
                            hint: '0123456123',
                            icon: AppAssets.call,
                            titleColor: AppColors.black,
                            isPassword: false,
                            hintColor:AppColors.black,
                            controller:
                                AuthCubit.get(context).registerNumberController,
                            onIconTap: () {},
                            fillColor: HexColor('#DADADA'),
                            borderRadius: 14.r,
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
                                      hint: 'ذكر',
                                      hintColor: AppColors.black,
                                      items: cubit.genders,
                                      value: cubit.selectedGender,
                                      fillColor: HexColor('#DADADA'),
                                      borderRadius: 14.r,
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
                                  hint: '12/12/2024',
                                  icon: AppAssets.date,
                                  titleColor: AppColors.black,
                                  hintColor:AppColors.black,

                                  isPassword: false,
                                  controller: AuthCubit.get(context)
                                      .registerDateController,
                                  // Use a dedicated controller
                                  fillColor: HexColor('#DADADA'),
                                  borderRadius: 14.r,

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
                                              primary: AppColors.primaryColor,
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
                                  suffixIcon: const Icon(Icons.calendar_today),
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
                                fillColor: HexColor('#DADADA'),
                                borderRadius: 14.r,
                                textInputAction: TextInputAction.done,
                                obscureText:
                                    AuthCubit.get(context).showPassword,
                                controller: AuthCubit.get(context)
                                    .registerPasswordController,
                                onIconTap: AuthCubit.get(context)
                                    .changePasswordVisibility,
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
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
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
                                              'تم تحديث بياناتك\nبنجاح',
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
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.r),
                                    gradient: LinearGradient(colors: [
                                      HexColor('#39FAD9'),
                                      HexColor('#03A186'),
                                    ]),
                                  ),
                                  child: Row(
                                    spacing: 8.w,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextBody14(
                                        'تحديث البيانات',
                                        color: AppColors.white,
                                      ),
                                      SvgPicture.asset(
                                        AppAssets.right,
                                        height: 16.h,
                                        width: 16.w,
                                        colorFilter: ColorFilter.mode(
                                            AppColors.white, BlendMode.srcIn),
                                      )
                                    ],
                                  )))
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}
