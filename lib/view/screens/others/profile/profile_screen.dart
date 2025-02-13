import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/view/screens/others/profile/components/change_password.dart';
import 'package:ecommerce/view/screens/others/profile/update_profile_screen/update_profile_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../view_model/data/local/shared_keys.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../common_components/custom_text_form_field/custom_text_form_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                          width: 50.w,
                        ),
                        GradientText(
                          'معلوماتك الشخصية',
                          gradient: LinearGradient(
                            colors: [
                              HexColor('#DCCF0F'),
                              HexColor('#8B8309'),
                            ],
                          ),
                          fontSize: 18.sp,
                        )
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
                    TextBody14(
                      SharedHelper.getData(SharedKeys.firstName),
                      color: AppColors.white,
                      shadows: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          offset: Offset(0.0, 3.h),
                          blurRadius: 6.0,
                        ),
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
                          CustomTextFormField(
                            title: LocaleKeys.firstName.tr(),
                            hint:
                                '${SharedHelper.getData(SharedKeys.firstName)}',
                            borderRadius: 14.r,
                            icon: AppAssets.profile,
                            titleColor: AppColors.black,
                            readOnly: true,
                            isPassword: false,
                            controller: AuthCubit.get(context)
                                .registerFirstNameController,
                            onIconTap: () {},
                            fillColor: AppColors.othersColor,
                            hintColor: AppColors.black,
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
                          CustomTextFormField(
                            readOnly: true,
                            fillColor: AppColors.othersColor,
                            hintColor: AppColors.black,
                            borderRadius: 14.r,
                            title: LocaleKeys.lastName.tr(),
                            hint:
                                '${SharedHelper.getData(SharedKeys.secondName)}',
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
                                return LocaleKeys.lastNameError.tr();
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                          ),
                          CustomTextFormField(
                            title: LocaleKeys.email.tr(),
                            hint: 'noor@1.com',
                            icon: AppAssets.email,
                            titleColor: AppColors.black,
                            isPassword: false,
                            readOnly: true,
                            borderRadius: 14.r,
                            controller:
                                AuthCubit.get(context).registerEmailController,
                            onIconTap: () {},
                            fillColor: AppColors.othersColor,
                            hintColor: AppColors.black,
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
                            fillColor: AppColors.othersColor,
                            hintColor: AppColors.black,
                            controller:
                                AuthCubit.get(context).registerNumberController,
                            onIconTap: () {},
                            readOnly: true,
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
                                    return CustomTextFormField(
                                      readOnly: true,
                                      title: LocaleKeys.gender.tr(),
                                      icon: AppAssets.gender,
                                      titleColor: AppColors.black,
                                      hint: 'ذكر',
                                      fillColor: AppColors.othersColor,
                                      hintColor: AppColors.black,
                                      borderRadius: 14.r,
                                      validator: (value) {
                                        if ((value ?? '').trim().isEmpty) {
                                          return LocaleKeys.genderError.tr();
                                        }
                                        return null;
                                      },
                                      isPassword: false,
                                      controller:
                                          cubit.registerGenderController,
                                      onIconTap: () {},
                                      suffixIcon: const Icon(Icons.email),
                                      obscureText: false,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: CustomTextFormField(
                                  borderRadius: 14.r,

                                  readOnly: true,
                                  fillColor: AppColors.othersColor,
                                  hintColor: AppColors.black,
                                  // Makes the field read-only
                                  title: LocaleKeys.birthDate.tr(),
                                  hint: '12/12/2024',
                                  icon: AppAssets.date,
                                  titleColor: AppColors.black,
                                  isPassword: false,
                                  controller: AuthCubit.get(context)
                                      .registerDateController,
                                  // Use a dedicated controller

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
                          Spacer(),
                          Transform.translate(
                            offset: Offset(0, 10.h),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return ChangePassword();
                                      });
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      spacing: 6.w,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextBody14(
                                          'تحديث كلمة المرور',
                                          color: AppColors.primaryColor,
                                        ),
                                        SvgPicture.asset(
                                          AppAssets.password,
                                          colorFilter: ColorFilter.mode(
                                              AppColors.primaryColor,
                                              BlendMode.srcIn),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: AppColors.primaryColor,
                                      thickness: 1.sp,
                                      endIndent: 80.w,
                                      indent: 80.w,

                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigation.push(context, UpdateProfileScreen());
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
                                        'تعديل البيانات الشخصية',
                                        color: AppColors.white,
                                      ),
                                      SvgPicture.asset(
                                        AppAssets.edit,
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
