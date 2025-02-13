import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../view_model/cubits/brands/brand_cubit.dart';
import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';
import '../seasons_drop_down/seasons_drop_down.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, required this.isOffers, required this.hasSeasonsDropDown});

  final String title;
  final bool isOffers;
final bool hasSeasonsDropDown;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: state.isAppBarVisible ? 40.h : -80.h,
          left: 0,
          right: 0,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: state.isAtTop ? 10.0 : 0.0,
                sigmaY: state.isAtTop ? 10.0 : 0.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: state.isAtTop
                      ? HexColor('#DCDCDC').withValues(alpha: 0.7)
                      : Colors.transparent,
                  boxShadow: state.isAtTop
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null, // No shadow when not at the top
                ),
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 60.w),

                    // Title
                    isOffers && !state.isAtTop
                        ? Hero(
                      tag: title,
                          child: Material(
                            type: MaterialType.transparency,
                            child: GradientText(title,
                                gradient: LinearGradient(colors: [
                                  HexColor('#DCCF0F'),
                                  HexColor('#8B8309'),
                                ]),
                                fontSize: 20.sp),
                          ),
                        )
                        : isOffers && state.isAtTop
                            ? Hero(
                              tag: title,
                              child: Material(
                                type: MaterialType.transparency,
                                child: TextTitle(
                                    title,
                                    color: AppColors.primaryColor,
                                    fontSize: 20.sp,
                                                      fontWeight: FontWeight.normal,
                                  ),
                              ),
                            )
                            : Hero(
                              tag: title,
                              child: Material(
                                type: MaterialType.transparency,
                                child: TextTitle(
                                    title,
                                    color: AppColors.primaryColor,
                                    fontSize: 18.sp,
                                  ),
                              ),
                            ),

                    Visibility(
                      replacement:SizedBox(width: 60.w,),
                        visible: hasSeasonsDropDown,
                        child: SeasonsDropDown()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
