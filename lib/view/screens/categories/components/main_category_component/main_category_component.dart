import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class MainCategoryComponent extends StatelessWidget {
  const MainCategoryComponent(
      {super.key,
      required this.image,
      required this.index,
      required this.title,
      required this.description,
      required this.onTap});

  final String image;
  final int index;
  final String title;
  final String description;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16.r),
      color: AppColors.grey,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.grey,
                spreadRadius: 0.9,
                blurRadius: 5.r,
                offset: const Offset(2, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(image),
            ),
          ),
          child: Stack(children: [
            Transform.translate(
              offset: Offset(0, 1.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
                crossAxisAlignment: index % 2 == 0
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Stack(children: [
                    Container(
                      width: 200.w,
                      height: 75.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          index % 2 == 0
                              ? 'assets/images/curve_right.png'
                              : 'assets/images/curve_left.png',
                        ).image,
                      )),
                      child: Align(
                        alignment: index % 2 == 0
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: Transform.rotate(
                              angle: index % 2 == 0
                                  ? 25 * (3.141592653589793 / 180)
                                  : -25 * (3.141592653589793 / 180),
                              child: TextBody14(
                                title,
                                color: AppColors.secondaryColor,
                                fontSize: 18.sp,
                              )),
                        ),
                      ),
                    ),
                  ]),
                  const Spacer(),
                  Transform.translate(
                    offset: Offset(0, 1.h),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: double.infinity,
                            height: 62.h,
                            padding: EdgeInsets.only(top: 6.h, bottom: 8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r),
                              ),
                              color: HexColor('#EFEFEF').withValues(alpha: 0.7),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Hero(
                                  tag: title,
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: TextTitle(
                                      title,
                                      color: AppColors.primaryColor,
                                      fontSize: 18.sp,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                TextBody14(
                                  description,
                                  fontSize: 12.sp,
                                  color: AppColors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
          ]),
        ),
      ),
    );
  }
}
