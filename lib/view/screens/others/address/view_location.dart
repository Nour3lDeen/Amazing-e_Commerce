import 'dart:ui';
import 'package:ecommerce/view/common_components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../view_model/cubits/auth/auth_cubit.dart';
import '../../../common_components/custom_button/custom_button.dart';

class ViewLocation extends StatelessWidget {
  const ViewLocation({super.key});

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
                          width: 75.w,
                        ),
                        GradientText(
                          'إضافة عنوان',
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16.h,
                        children: [
                          CustomTextFormField(
                              title: 'اسم صاحب العنوان',
                              hint: 'نور الدين جمال',
                              readOnly: true,
                              fillColor: AppColors.othersColor,
                              titleColor: AppColors.black,
                              icon: AppAssets.locationPerson,
                              hintColor: AppColors.black,
                              isPassword: false,
                              controller: TextEditingController(),
                              onIconTap: () {},
                              hasShadow: true,
                              borderRadius: 14.r,
                              suffixIcon: Icon(Icons.abc),
                              obscureText: false),
                          CustomTextFormField(
                              title: 'اسم العنوان',
                              hint: 'العمل',
                              readOnly: true,
                              fillColor: AppColors.othersColor,
                              titleColor: AppColors.black,
                              icon: AppAssets.locationName,
                              hintColor: AppColors.black,
                              isPassword: false,
                              controller: TextEditingController(),
                              onIconTap: () {},
                              hasShadow: true,
                              borderRadius: 14.r,
                              suffixIcon: Icon(Icons.abc),
                              obscureText: false),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                    title: 'الدولة',
                                    hint: 'مصر',
                                    titleColor: AppColors.black,
                                    icon: AppAssets.country,
                                    hintColor: AppColors.black,
                                    readOnly: true,
                                    fillColor: AppColors.othersColor,
                                    isPassword: false,
                                    controller: TextEditingController(),
                                    onIconTap: () {},
                                    hasShadow: true,
                                    borderRadius: 14.r,
                                    suffixIcon: Icon(Icons.abc),
                                    obscureText: false),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: CustomTextFormField(
                                    title: 'المدينة',
                                    hint: 'شبرا الخيمة',
                                    titleColor: AppColors.black,
                                    icon: AppAssets.city,
                                    hintColor: AppColors.black,
                                    readOnly: true,
                                    fillColor: AppColors.othersColor,
                                    isPassword: false,
                                    controller: TextEditingController(),
                                    onIconTap: () {},
                                    hasShadow: true,
                                    borderRadius: 14.r,
                                    suffixIcon: Icon(Icons.abc),
                                    obscureText: false),
                              ),
                            ],
                          ),
                          CustomTextFormField(
                              title: 'العنوان تفصيلي',
                              hint:
                                  'شبرا الخيمة أخر شارع عبد السلام عارف المصنع اللي بابه إزاز',
                              titleColor: AppColors.black,
                              icon: AppAssets.locationDetails,
                              hintColor: AppColors.black,
                              readOnly: true,
                              fillColor: AppColors.othersColor,
                              isPassword: false,
                              maxLines: 4,
                              controller: TextEditingController(),
                              onIconTap: () {},
                              hasShadow: true,
                              borderRadius: 14.r,
                              suffixIcon: Icon(Icons.abc),
                              obscureText: false),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                    title: 'رقم الجوال',
                                    hint: '0123456789',
                                    titleColor: AppColors.black,
                                    icon: AppAssets.phone,
                                    hintColor: AppColors.black,
                                    readOnly: true,
                                    fillColor: AppColors.othersColor,
                                    isPassword: false,
                                    controller: TextEditingController(),
                                    onIconTap: () {},
                                    hasShadow: true,
                                    keyboardType: TextInputType.number,
                                    borderRadius: 14.r,
                                    suffixIcon: Icon(Icons.abc),
                                    obscureText: false),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: CustomTextFormField(
                                    title: 'رقم جوال إضافي',
                                    hint: '0123456789',
                                    titleColor: AppColors.black,
                                    icon: AppAssets.extraPhone,
                                    keyboardType: TextInputType.number,
                                    hintColor: AppColors.black,
                                    hasShadow: true,
                                    readOnly: true,
                                    fillColor: AppColors.othersColor,
                                    isPassword: false,
                                    controller: TextEditingController(),
                                    onIconTap: () {},
                                    borderRadius: 14.r,
                                    suffixIcon: Icon(Icons.abc),
                                    obscureText: false),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            spacing: 8.w,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.15),
                                            offset: Offset(0.0, 3.h),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        gradient: LinearGradient(colors: [
                                          HexColor('#66B873'),
                                          HexColor('#0AB023'),
                                        ]),
                                        borderRadius: BorderRadius.circular(
                                          14.r,
                                        )),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 6.w,
                                        children: [
                                          TextBody14(
                                            'تعديل العنوان',
                                            fontSize: 16.sp,
                                            color: AppColors.white,
                                          ),
                                          SvgPicture.asset(
                                            AppAssets.edit1,
                                            colorFilter: ColorFilter.mode(
                                              AppColors.white,
                                              BlendMode.srcIn,
                                            ),
                                            height: 18.h,
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 16.h,
                                                              horizontal: 24.w),
                                                      //EdgeInsets.all(50.sp),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              AppColors.white,
                                                          width: 2.w,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                      ),
                                                      child: Column(
                                                          spacing: 8.h,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .error_outline_rounded,
                                                              color:
                                                                  AppColors.red,
                                                              size: 50.sp,
                                                            ),
                                                            TextBody14(
                                                              'سيتم حذف العنوان \nهل انت متأكد؟',
                                                              fontSize: 16.sp,
                                                              color: AppColors
                                                                  .black,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                CustomButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                    AuthCubit.get(context).viewToast(
                                                                        'تم حذف العنوان ',
                                                                        context,
                                                                        AppColors
                                                                            .red);
                                                                  },
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: [
                                                                        HexColor(
                                                                          '#DA6A6A',
                                                                        ),
                                                                        HexColor(
                                                                          '#B20707',
                                                                        )
                                                                      ]),
                                                                  borderRadius:
                                                                      8.r,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            4.h),
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          95.w,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          TextBody12(
                                                                            'حذف',
                                                                            color:
                                                                                AppColors.white,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 4.w),
                                                                          SvgPicture
                                                                              .asset(
                                                                            AppAssets.delete,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                CustomButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .white,
                                                                  child:
                                                                      Container(
                                                                    width: 95.w,
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            4.h),
                                                                    decoration: BoxDecoration(
                                                                        color: AppColors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8
                                                                                .r),
                                                                        border: Border.all(
                                                                            color:
                                                                                AppColors.red,
                                                                            width: 1)),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        TextBody12(
                                                                          'إلغاء',
                                                                          color:
                                                                              AppColors.red,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                4.w),
                                                                        Icon(
                                                                          Icons
                                                                              .cancel_outlined,
                                                                          color:
                                                                              AppColors.red,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ]))));
                                        });
                                  },
                                  child: Container(
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.15),
                                            offset: Offset(0.0, 3.h),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        gradient: LinearGradient(colors: [
                                          HexColor('#DA6A6A'),
                                          HexColor('#B20707'),
                                        ]),
                                        borderRadius: BorderRadius.circular(
                                          14.r,
                                        )),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 6.w,
                                        children: [
                                          TextBody14(
                                            'حذف العنوان',
                                            fontSize: 16.sp,
                                            color: AppColors.white,
                                          ),
                                          SvgPicture.asset(
                                            AppAssets.delete,
                                            height: 18.h,
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
