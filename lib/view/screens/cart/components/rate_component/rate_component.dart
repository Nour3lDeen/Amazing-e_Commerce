import 'dart:ui';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class RateComponent extends StatelessWidget {
  const RateComponent({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white.withValues(alpha: 0.65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6.0,
          sigmaY: 6.0,
        ),
        child: Container(
          width: 300.w,
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6.h,
            children: [
              const TextBody14(
                'يسعدنا مشاركتكم بتقييم منتجاتنا مما يساعدنا في تقديم ما يناسبكم دائما.',
                textAlign: TextAlign.center,
              ),
              Center(child: SvgPicture.asset(AppAssets.rateIcon)),
              RatingBar(
                filledIcon: Icons.star,
                alignment: Alignment.center,
                emptyIcon: Icons.star_border,
                halfFilledIcon: Icons.star_half,
                filledColor: HexColor('#FFCB45'),
                initialRating: ProductsCubit.get(context).rate.toDouble(),
                size: 30.sp,
                onRatingChanged: (double rating) {
                  ProductsCubit.get(context).setRate(rating);
                },
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: TextBody12(
                  'إضافة تعليق',
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                maxLines: 4,
                minLines: 3,
                textInputAction: TextInputAction.send,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.black,
                  fontFamily: 'Lamar',
                ),
                controller: ProductsCubit.get(context).rateController,
                cursorColor: AppColors.primaryColor,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'اكتب تعليقك',
                  hintStyle: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.grey,
                    fontFamily: 'Lamar',
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  fillColor: AppColors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              BlocConsumer<ProductsCubit, ProductsState>(
                listener: (context, state) {
                  if (state is SendRateSuccessState) {
                    Navigator.pop(context);
                    AuthCubit.get(context)
                        .viewToast('تم إرسال تقييمك', context, Colors.green, 2);
                  } else if (state is SendRateErrorState) {
                    AuthCubit.get(context)
                        .viewToast(state.msg, context, Colors.red, 4);
                  }
                },
                builder: (context, state) {
                  if (state is SendRateLoadingState) {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                        size: 20.sp,
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                  return Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () {
                        ProductsCubit.get(context)
                            .sendRate(productId: productId);
                      },
                      child: Container(
                        width: 110.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              HexColor('#31D3C6'),
                              HexColor('#208B78'),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: Offset(1.w, 3.h),
                              blurRadius: 6.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 6.w,
                          children: [
                            TextBody12(
                              'إرسال',
                              color: AppColors.white,
                            ),
                            SvgPicture.asset(
                              AppAssets.send,
                              colorFilter: ColorFilter.mode(
                                  AppColors.white, BlendMode.srcIn),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
