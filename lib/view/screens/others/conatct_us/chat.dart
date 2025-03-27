import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/view/common_components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../view_model/data/local/shared_keys.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Dialog(
          backgroundColor: AppColors.white.withValues(alpha: 0.65),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height *
                0.7,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.white,
width: 2.sp
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 38.h,
                              width: 38.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(AppAssets.chatRep),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.15),
                                      offset: Offset(0.0, 3.h),
                                      blurRadius: 6.0,
                                    )
                                  ]),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            GradientText(
                              'خدمة عملاء Amazing',
                              gradient: LinearGradient(
                                colors: [
                                  HexColor('#DCCF0F'),
                                  HexColor('#8B8309'),
                                ],
                              ),
                              fontSize: 16.sp,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.15),
                                        offset: Offset(2.w, 3.h),
                                        blurRadius: 6.0,
                                      )
                                    ]),
                                child: SvgPicture.asset(
                                  AppAssets.exit,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextBody12(
                          'هذه المحادثة قد تكون مسجلة حرصًا منا على تقديم خدمة أفضل',
                          color: HexColor('#D04948'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: 12.w, left: 12.w, bottom: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16.r),
                                bottomRight: Radius.circular(16.r)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  physics: const ClampingScrollPhysics(),
                                  reverse: true,
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors.black
                                                          .withValues(
                                                              alpha: 0.15),
                                                      offset: Offset(2.w, 3.h),
                                                      blurRadius: 6.0,
                                                    )
                                                  ]),
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: 16.r,
                                                  child: ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          SharedHelper.getData(
                                                                  SharedKeys
                                                                      .avatar)
                                                              .replaceFirst(
                                                                  'http://',
                                                                  'https://'),
                                                      height: 32.h,
                                                      width: 32.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ))),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14.w,
                                                vertical: 8.h),
                                            width: 200.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12.r),
                                                    bottomLeft:
                                                        Radius.circular(12.r),
                                                    topRight:
                                                        Radius.circular(12.r)),
                                                color: AppColors.othersColor),
                                            child: TextBody14(
                                                fontSize: 12.sp,
                                                'عليكم السلام \nيمكنني الاستفسار بخصوص بنطلون جبردين ازرق ,متي سيكون متوافر لديكم؟'),
                                          )
                                        ]),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14.w,
                                                vertical: 8.h),
                                            width: 200.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12.r),
                                                    bottomRight:
                                                        Radius.circular(12.r),
                                                    topRight:
                                                        Radius.circular(12.r)),
                                                color: AppColors.white),
                                            child: TextBody14(
                                                fontSize: 12.sp,
                                                'السلام عليكم\nمرحباً بكم في خدمة عملاء خلابة. يسعدني تقديم المساعدة لكم'),
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors.black
                                                          .withValues(
                                                              alpha: 0.15),
                                                      offset: Offset(2.w, 3.h),
                                                      blurRadius: 6.0,
                                                    )
                                                  ]),
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: 16.r,
                                                  child: ClipOval(
                                                      child: Image.asset(
                                                          AppAssets.chatRep)))),
                                        ]),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 28.w,
                                    height: 28.h,
                                    padding: EdgeInsets.all(4.sp),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                        SvgPicture.asset(AppAssets.attachment),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Container(
                                      width: 200.w,
                                      height: 28.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        color: AppColors.white,
                                      ),
                                      child: TextFormField(
                                        maxLines: 3,
                                        minLines: 2,
                                        textInputAction: TextInputAction.send,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.black,
                                          fontFamily: 'Lamar',
                                        ),
                                        cursorColor: AppColors.primaryColor,
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          hintText: 'رسالة...',
                                          hintStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: AppColors.grey,
                                            fontFamily: 'Lamar',
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 8.h),
                                          fillColor: AppColors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide.none),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide.none),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide.none),
                                        ),
                                      )),
                                  const Spacer(),
                                  Container(
                                    width: 28.w,
                                    height: 28.h,
                                    padding: EdgeInsets.all(4.sp),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                    SvgPicture.asset(AppAssets.directSend),
                                  )
                                ],
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
        ),
      ),
    );
  }
}
