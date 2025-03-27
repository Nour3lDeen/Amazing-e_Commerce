import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/data/local/shared_helper.dart';
import '../../../../../view_model/data/local/shared_keys.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                  children: [
                    Row(
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
                          width: 65.w,
                        ),
                        GradientText(
                          'سياسة الخصوصية',
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
                    SvgPicture.asset(
                      AppAssets.privacyPolicy,
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
                      children: [
                        TextTitle(
                          'Privacy Policy Terms',
                          fontSize: 18.sp,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextBody14(
                          textAlign: TextAlign.center,
                          'At Amazing , we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our clothing application.',
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextBody14(textAlign:TextAlign.left,
                                      '''
:Information We Collect\n
We may collect the following types of information:\n
- **Personal Information:** Name, email address, phone number, shipping address, and payment details.\n
- **Usage Data:** Information about how you interact with our app, including your browsing and purchasing behavior.\n
- **Device Information:** Details about the device you use to access the app, such as the device type, operating system, and IP address.\n\n

 :How We Use Your Information\n
:The information we collect is used for\n
- Processing and fulfilling your orders.\n
- Improving your shopping experience through personalized recommendations.\n
- Communicating with you regarding updates, promotions, and customer service inquiries.\n
- Enhancing our app’s functionality and security.\n\n

 :Sharing Your Information\n
We do not sell or rent your personal information to third parties. However, we may share your data with:\n
- **Service Providers:** For payment processing, delivery services, and app analytics.\n
- **Legal Authorities:** If required by law or to protect the rights of the company.\n\n

 :Data Security\n
We implement robust security measures to protect your information from unauthorized access, alteration, or disclosure.\n
However, no method of transmission over the internet is 100% secure.\n\n

 :Your Rights\n
:You have the right to\n
- Access, update, or delete your personal information.\n
- Opt-out of receiving marketing communications.\n
- Request a copy of your data or restrict its processing.\n\n

 :Retention of Data\n
We retain your data only as long as necessary to provide our services or as required by law.\n\n

 :Changes to This Policy\n
We may update this Privacy Policy periodically. Any changes will be communicated through the app or our website.\n
''')

                                ],
                              ),
                            ))
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
