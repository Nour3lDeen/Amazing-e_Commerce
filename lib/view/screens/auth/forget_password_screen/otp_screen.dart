import 'dart:ui';

import 'package:ecommerce/view/screens/auth/forget_password_screen/create_new_password_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Directionality(
            textDirection: TextDirection.rtl,
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
                    'نسيت كلمة المرور',
                    textAlign: TextAlign.center,

                    color: AppColors.secondaryColor,
                    //fontFamily: 'Lamar',
                    fontSize: 18.sp,
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
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha:0.35),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextTitle('التحقق من الكود'),
                              SizedBox(
                                height: 12.h,
                              ),
                              const TextBody14(
                                  'قم بكتابة الكود المرسل إليك علي البريد الإلكتروني.'),
                              SizedBox(
                                height: 20.h,
                              ),
                              /*CustomTextFormField(
                                title: 'الكود',
                                hint: 'أدخل الكود',
                               //icon: AppAssets.email,
                                titleColor: AppColors.black,
                                isPassword: false,
                                controller:
                                AuthCubit
                                    .get(context)
                                    .otpController,
                                onIconTap: () {},
                                suffixIcon: const Icon(Icons.email),
                                obscureText: false,
                                validator: (value) {
                                  if ((value ?? '')
                                      .trim()
                                      .isEmpty) {
                                    return 'الرجاء إدخال الكود';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,

                              ),*/
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: OtpTextField(
                                  numberOfFields: 5,
                                  borderColor: AppColors.primaryColor,
                                  //borderWidth: 0,
                                  borderRadius: BorderRadius.circular(8.r),
                                  showFieldAsBox: true,
                                 //enabledBorderColor: AppColors.primaryColor,
                                  focusedBorderColor: AppColors.secondaryColor,
                                  fillColor: AppColors.white.withValues(alpha:0.65),
                                  filled: true,
                                  cursorColor: AppColors.secondaryColor,
                                  keyboardType: TextInputType.number,
                                  fieldWidth: 40.w,
                                  fieldHeight: 40.h,
                                  onSubmit: (String verificationCode) {
                                    // do something with the code
                                    AuthCubit.get(context).otpController.text = verificationCode;
                                    debugPrint('OTP1: ${AuthCubit.get(context).otpController.text}');
                                    AuthCubit.get(context).clearData();

                                    debugPrint('${AuthCubit.get(context).showPassword}');
                                    Navigation.pushReplacement(context, const CreateNewPasswordScreen());
                                    /// todo request code
                                  },
                                  onCodeChanged: (String code) {
                                    AuthCubit.get(context).otpController.text = code;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 12.h,),
                             Center(
                               child: Material(
                                 borderRadius: BorderRadius.circular(16.r),
                                 color: Colors.transparent,
                                 child: InkWell(
                                   onTap: (){
                                     AuthCubit.get(context).clearData();
                                     Navigator.pop(context);
                                   },
                                   borderRadius: BorderRadius.circular(16.r),
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(horizontal: 4.w),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         TextTitle('تعديل البريد الإلكتروني',color: AppColors.primaryColor,),
                                         SizedBox(width: 8.w,),
                                         SvgPicture.asset(AppAssets.edit,height: 20.h,width: 20.h,),
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
