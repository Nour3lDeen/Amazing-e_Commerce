import 'dart:ui';
import 'package:ecommerce/view/common_components/custom_drop_down/custom_drop_down.dart';
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

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
        body: Stack(
      children: [
        PositionedDirectional(
          start: 0,
          top: 0.h,
          end: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: SharedHelper.getData(SharedKeys.platform) == 'android'
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
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
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
                          hint: 'أدخل اسم صاحب العنوان',
                          titleColor: AppColors.black,
                          icon: AppAssets.locationPerson,
                          hintColor: AppColors.black.withValues(alpha: 0.4),
                          fillColor: HexColor('#DADADA'),
                          isPassword: false,
                          controller: TextEditingController(),
                          onIconTap: () {},
                          hasShadow: true,
                          borderRadius: 14.r,
                          suffixIcon: Icon(Icons.abc),
                          obscureText: false),
                      CustomTextFormField(
                          title: 'اسم العنوان',
                          hint: 'اسم العنوان/ المنزل - العمل - ..',
                          titleColor: AppColors.black,
                          icon: AppAssets.locationName,
                          hintColor: AppColors.black.withValues(alpha: 0.4),
                          fillColor: HexColor('#DADADA'),
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
                            child: CustomDropdownFormField(
                              title: 'الدولة',
                              icon: AppAssets.country,
                              titleColor: AppColors.black,
                              hasShadow: true,
                              hintColor: AppColors.black,
                              hint: 'الدولة',
                              borderRadius: 14.r,
                              fillColor: HexColor('#DADADA'),
                              items: ['مصر','السعودية'],
                              onChanged: (value) {},
                              value: 'السعودية',
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                            child: CustomDropdownFormField(
                              title: 'المدينة',
                              icon: AppAssets.city,
                              titleColor: AppColors.black,
                              hasShadow: true,
                              hintColor: AppColors.black,
                              borderRadius: 14.r,
                              hint: 'المدينة',
                              fillColor: HexColor('#DADADA'),
                              items: [],
                              onChanged: (value) {},
                              value: '',
                            ),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                          title: 'العنوان تفصيلي',
                          hint:
                              'العنوان تفصيلا( الشارع - البناية - الطابق - الشقة) ',
                          titleColor: AppColors.black,
                          icon: AppAssets.locationDetails,
                          hintColor: AppColors.black.withValues(alpha: 0.4),
                          fillColor: HexColor('#DADADA'),
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
                                hint: 'أدخل رقم الجوال',
                                titleColor: AppColors.black,
                                icon: AppAssets.phone,
                                hintColor:
                                    AppColors.black.withValues(alpha: 0.4),
                                fillColor: HexColor('#DADADA'),
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
                                hint: 'أدخل رقم الجوال',
                                titleColor: AppColors.black,
                                icon: AppAssets.extraPhone,
                                keyboardType: TextInputType.number,
                                hintColor:
                                    AppColors.black.withValues(alpha: 0.4),
                                hasShadow: true,
                                fillColor: HexColor('#DADADA'),
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
                      GestureDetector(
                        onTap: () {},
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
