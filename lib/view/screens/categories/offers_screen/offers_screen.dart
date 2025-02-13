import 'package:ecommerce/view/common_components/custom_app_bar/custom_app_bar.dart';
import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../view_model/cubits/brands/brand_cubit.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../home/bottom_nav_bar/components/offers_component/product_card.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
  builder: (context, state) {
    final cubit = BrandCubit.get(context);
    return Scaffold(
      body: Stack(
        children:[ Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(AppAssets.back).image,
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            controller: cubit.scrollController,
            padding: EdgeInsets.only(top: 90.h),
            children: [
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16.w,
                children: [
                  SizedBox(
                    width: 110.w,
                    height: 32.h,
                    child: CustomButton(
                      borderRadius: 8.r,
                      gradient: LinearGradient(colors: [
                        HexColor('#31D3C6'),
                        HexColor('#208B78'),
                      ]),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Center(
                          child: TextBody14('جميع العروض',
                              fontSize: 14.sp, color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 110.w,
                      height: 32.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border:
                            Border.all(color: AppColors.primaryColor, width: 1),
                      ),
                      child: Center(
                          child: TextBody14(
                        'أحدث العروض',
                        color: AppColors.black,
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8.w,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 70.w,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: TextBody14(
                            'الكل',
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 70.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border:
                            Border.all(color: AppColors.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: TextBody14(
                          'رجالي ',
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 70.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border:
                            Border.all(color: AppColors.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: TextBody14(
                          'نسائي ',
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 70.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border:
                            Border.all(color: AppColors.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: TextBody14(
                          'أطفالي  ',
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Center(
                child: Wrap(
                  spacing: 16.w,
                  runSpacing: 16.h,
                  children: List.generate(
                      20,
                      (index) => ProductCard(
                            hasDiscount: true,
                            fromHome: true,
                            productId: index,
                            title: 'قميص كاروهات',
                            image:
                                'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                          )),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
        CustomAppBar(title: 'عروض Amazing', isOffers: true,hasSeasonsDropDown:true,),
          PositionedDirectional(
            top: 48.h,
            start: 0.w,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 1),
                    ),
                  ]),
                  child: SvgPicture.asset(
                    AppAssets.backIcon,
                    height: 28.h,
                    width: 28.w,
                  ),
                ),
              ),
            ),
          ),

        ]
      ),
    );
  },
);
  }
}
