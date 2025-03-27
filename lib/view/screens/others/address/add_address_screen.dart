import 'dart:ui';
import 'package:ecommerce/model/auth/user.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key, required this.isUpdate, this.addressId});

  final bool isUpdate;
  final int? addressId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            AuthCubit.get(context).clearData();
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
                          width: 75.w,
                        ),
                        GradientText(
                          isUpdate ? 'تعديل العنوان' : 'إضافة عنوان',
                          gradient: LinearGradient(
                            colors: [
                              HexColor('#DCCF0F'),
                              HexColor('#8B8309'),
                            ],
                          ),
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: Offset(1.w, 3.h),
                              blurRadius: 6,
                            ),
                          ],
                          fontSize: 18.sp,
                        )
                      ],
                    ),
                    SvgPicture.asset(
                      AppAssets.address,
                      height: 75.h,
                      width: 75.w,
                    ),
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
                    child: SingleChildScrollView(
                      child: Form(
                        key: AuthCubit.get(context).addAddressFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 16.h,
                          children: [
                            CustomTextFormField(
                                title: 'اسم صاحب العنوان',
                                hint: 'أدخل اسم صاحب العنوان',
                                titleColor: AppColors.black,
                                icon: AppAssets.locationPerson,
                                hintColor:
                                    AppColors.black.withValues(alpha: 0.4),
                                fillColor: HexColor('#DADADA'),
                                isPassword: false,
                                controller: AuthCubit.get(context)
                                    .addressFullNameController,
                                onIconTap: () {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'يرجى إدخال اسم صاحب العنوان';
                                  }
                                  return null;
                                },
                                hasShadow: false,
                                borderRadius: 14.r,
                                suffixIcon: const Icon(Icons.abc),
                                obscureText: false),
                            CustomTextFormField(
                                title: 'اسم العنوان',
                                hint: 'اسم العنوان/ المنزل - العمل - ..',
                                titleColor: AppColors.black,
                                icon: AppAssets.locationName,
                                hintColor:
                                    AppColors.black.withValues(alpha: 0.4),
                                fillColor: HexColor('#DADADA'),
                                isPassword: false,
                                controller: AuthCubit.get(context)
                                    .addressNameController,
                                onIconTap: () {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'يرجى إدخال اسم العنوان';
                                  }
                                  return null;
                                },
                                hasShadow: false,
                                borderRadius: 14.r,
                                suffixIcon: const Icon(Icons.abc),
                                obscureText: false),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdownFormField(
                                    title: 'الدولة',
                                    icon: AppAssets.country,
                                    titleColor: AppColors.black,
                                    hasShadow: false,
                                    //hintColor: AppColors.black,
                                    hint: 'اختر الدولة',
                                    borderRadius: 14.r,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'يرجى إدخال الدولة';
                                      }
                                      return null;
                                    },
                                    fillColor: HexColor('#DADADA'),
                                    items: AuthCubit.get(context).myCountries,
                                    onChanged: (value) {
                                      AuthCubit.get(context)
                                          .changeCountry(value);
                                    },
                                    value:
                                        AuthCubit.get(context).selectedCountry,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    return Expanded(
                                      child: CustomDropdownFormField(
                                        title: 'المدينة',
                                        icon: AppAssets.city,
                                        titleColor: AppColors.black,
                                        hasShadow: false,
                                        //hintColor: AppColors.black,
                                        borderRadius: 14.r,
                                        hint: 'اختر المدينة',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'يرجى إدخال المدينة';
                                          }
                                          return null;
                                        },
                                        fillColor: HexColor('#DADADA'),
                                        items: AuthCubit.get(context).myCities,
                                        onChanged: (value) {
                                          AuthCubit.get(context)
                                              .changeCity(value);
                                        },
                                        value:
                                            AuthCubit.get(context).selectedCity,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            CustomTextFormField(
                                title: 'العنوان تفصيلي',
                                hint:
                                    'العنوان تفصيلا( الشارع - البناية - الطابق - الشقة) ',
                                titleColor: AppColors.black,
                                icon: AppAssets.locationDetails,
                                hintColor:
                                    AppColors.black.withValues(alpha: 0.4),
                                fillColor: HexColor('#DADADA'),
                                isPassword: false,
                                maxLines: 4,
                                controller: AuthCubit.get(context)
                                    .addressDescriptionController,
                                onIconTap: () {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'يرجى إدخال العنوان التفصيلي';
                                  }
                                  return null;
                                },
                                hasShadow: false,
                                borderRadius: 14.r,
                                suffixIcon: const Icon(Icons.abc),
                                obscureText: false),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                      title: 'رقم الجوال',
                                      hint: 'أدخل رقم الجوال',
                                      titleColor: AppColors.black,
                                      icon: AppAssets.phone,
                                      hintColor: AppColors.black
                                          .withValues(alpha: 0.4),
                                      fillColor: HexColor('#DADADA'),
                                      isPassword: false,
                                      controller: AuthCubit.get(context)
                                          .addressPhoneController,
                                      onIconTap: () {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'يرجى إدخال رقم الجوال';
                                        }
                                        return null;
                                      },
                                      hasShadow: false,
                                      keyboardType: TextInputType.number,
                                      borderRadius: 14.r,
                                      suffixIcon: const Icon(Icons.abc),
                                      obscureText: false),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Expanded(
                                  child: CustomTextFormField(
                                      title: 'رقم جوال إضافي',
                                      hint: 'أدخل رقم الجوال',
                                      titleColor: AppColors.black,
                                      icon: AppAssets.extraPhone,
                                      keyboardType: TextInputType.number,
                                      hintColor: AppColors.black
                                          .withValues(alpha: 0.4),
                                      hasShadow: false,
                                      fillColor: HexColor('#DADADA'),
                                      isPassword: false,
                                      controller: AuthCubit.get(context)
                                          .addressOtherPhoneController,
                                      onIconTap: () {},
                                      borderRadius: 14.r,
                                      suffixIcon: const Icon(Icons.abc),
                                      obscureText: false),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                final authCubit = AuthCubit.get(context);
                                if (!isUpdate) {
                                  if (state is AddAddressSuccessState) {
                                    authCubit.getUserData();
                                    authCubit.clearData();
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor: AppColors.white
                                            .withValues(alpha: 0.65),
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
                                                vertical: 30.h,
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
                                                  'تم حفظ العنوان\nبنجاح',
                                                  fontSize: 18.sp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    Future.delayed(const Duration(seconds: 2))
                                        .then(
                                      (value) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (state is AddAddressErrorState) {
                                    authCubit.viewToast(
                                        state.msg, context, AppColors.red, 4);
                                  }
                                } else {
                                  if (state is UpdateAddressSuccessState) {
                                    authCubit.getUserData();
                                    authCubit.clearData();
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor: AppColors.white
                                            .withValues(alpha: 0.65),
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
                                                vertical: 30.h,
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
                                                  'تم تعديل العنوان\nبنجاح',
                                                  fontSize: 18.sp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    Future.delayed(const Duration(seconds: 2))
                                        .then(
                                      (value) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (state is UpdateAddressErrorState) {
                                    authCubit.viewToast(
                                        state.msg, context, AppColors.red, 4);
                                  }
                                }
                              },
                              builder: (context, state) {
                                final authCubit = AuthCubit.get(context);
                                if (state is AddAddressLoadingState ||
                                    state is UpdateAddressLoadingState) {
                                  return LoadingAnimationWidget.inkDrop(
                                      color: AppColors.primaryColor,
                                      size: 20.sp);
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      if (!isUpdate) {
                                        authCubit.addAddress(context);
                                      } else {
                                        authCubit.updateAddress(addressId ?? 0);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 36.h,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            HexColor('#39FAD9'),
                                            HexColor('#03A186'),
                                          ]),
                                          borderRadius: BorderRadius.circular(
                                            14.r,
                                          )),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          spacing: 6.w,
                                          children: [
                                            TextBody14(
                                              'حفظ العنوان',
                                              fontSize: 16.sp,
                                              color: AppColors.white,
                                            ),
                                            SvgPicture.asset(
                                              AppAssets.addLocation,
                                              height: 18.h,
                                            )
                                          ]),
                                    ),
                                  );
                                }
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
        ));
  }
}
