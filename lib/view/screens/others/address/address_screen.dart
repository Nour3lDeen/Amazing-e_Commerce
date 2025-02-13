import 'dart:ui';
import 'package:ecommerce/view/screens/others/address/add_address_screen.dart';
import 'package:ecommerce/view/screens/others/address/components/location_component.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      'عناوين الشحن',
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16.h,
                  children: [
                    Visibility(
                      visible: true,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.savedLocation,
                            height: 18.h,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          TextTitle('العناوين المسجلة')
                        ],
                      ),
                    ),
                    Visibility(
                      visible: false,
                      replacement: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 8.h,
                            children: List.generate(
                              6,
                              (index) {
                                return LocationComponent();
                              },
                            ),
                          ),
                        ),
                      ),
                      child: TextBody14(
                        'لم يتم إضافة عناوين إلى عناوين \nالشحن الخاصة بكم',
                        color: AppColors.primaryColor,
                        textAlign: TextAlign.center,
                        fontSize: 16.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigation.push(context, const AddAddressScreen());
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 6.w,
                            children: [
                              TextBody14(
                                'إضافة عنوان',
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
      ],
    ));
  }
}
