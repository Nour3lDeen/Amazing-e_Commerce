import 'dart:math';

import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view/common_components/custom_app_bar/custom_app_bar.dart';
import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../view_model/cubits/brands/brand_cubit.dart';
import '../../../../view_model/cubits/products/products_cubit.dart';
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
        return BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            List<Products> discountedProducts = ProductsCubit.get(context)
                .everyProducts
                .where((e) =>
                    e.sizes!.first.discountRate! != 0 &&
                    ((ProductsCubit.get(context).selectedSectionIndex == -1 ||
                            e.sectionId ==
                                ProductsCubit.get(context).selectedSectionId) &&
                        (ProductsCubit.get(context).selectedIndexSeason == -1 ||
                            e.seasonId ==
                                ProductsCubit.get(context).selectedSeasonId)))
                .toList();
            return Scaffold(
              body: Stack(children: [
                Container(
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
                        spacing: 16.w,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ProductsCubit.get(context).changeOffer(0);
                            },
                            child: Container(
                                width: 110.w,
                                height: 32.h,
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                decoration: BoxDecoration(
                                  color:
                                      ProductsCubit.get(context).offerIndex == 0
                                          ? null
                                          : AppColors.white,
                                  gradient:
                                      ProductsCubit.get(context).offerIndex == 0
                                          ? LinearGradient(colors: [
                                              HexColor('#31D3C6'),
                                              HexColor('#208B78'),
                                            ])
                                          : null,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                ),
                                child: Center(
                                  child: TextBody14('جميع العروض',
                                      fontSize: 14.sp,
                                      color: ProductsCubit.get(context)
                                                  .offerIndex ==
                                              0
                                          ? AppColors.white
                                          : AppColors.black),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              ProductsCubit.get(context).changeOffer(1);
                            },
                            child: Container(
                              width: 110.w,
                              height: 32.h,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                color:
                                    ProductsCubit.get(context).offerIndex == 1
                                        ? null
                                        : AppColors.white,
                                gradient:
                                    ProductsCubit.get(context).offerIndex == 1
                                        ? LinearGradient(colors: [
                                            HexColor('#31D3C6'),
                                            HexColor('#208B78'),
                                          ])
                                        : null,
                                borderRadius: BorderRadius.circular(8.r),
                                border:
                                    Border.all(color: AppColors.primaryColor),
                              ),
                              child: Center(
                                  child: TextBody14(
                                'أحدث العروض',
                                color:
                                    ProductsCubit.get(context).offerIndex == 1
                                        ? AppColors.white
                                        : AppColors.black,
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 8.w,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ProductsCubit.get(context)
                                      .changeSelectedSection(-1);
                                },
                                child: Container(
                                  width: 70.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                      color: ProductsCubit.get(context)
                                                  .selectedSectionIndex ==
                                              -1
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      )),
                                  child: Center(
                                    child: TextBody14(
                                      'الكل',
                                      color: ProductsCubit.get(context)
                                                  .selectedSectionIndex ==
                                              -1
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                  spacing: 8.w,
                                  children: List.generate(
                                    ProductsCubit.get(context).sections.length,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        ProductsCubit.get(context)
                                            .changeSelectedSection(index);
                                      },
                                      child: Container(
                                        width: 70.w,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          color: ProductsCubit.get(context)
                                                      .selectedSectionIndex ==
                                                  index
                                              ? AppColors.primaryColor
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: TextBody14(
                                            ProductsCubit.get(context)
                                                    .sections[index]
                                                    .name ??
                                                '',
                                            color: ProductsCubit.get(context)
                                                        .selectedSectionIndex ==
                                                    index
                                                ? AppColors.white
                                                : AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Visibility(
                        visible: discountedProducts.isNotEmpty,
                        replacement: Column(
                          children: [
                            SizedBox(
                              height: 200.h,
                            ),
                            const Center(
                                child: TextTitle('لا يوجد عروض حاليًا')),
                          ],
                        ),
                        child: Wrap(
                          spacing: 16.w,
                          runSpacing: 16.h,
                          alignment: WrapAlignment.spaceBetween,
                          children: ProductsCubit.get(context).offerIndex == 1
                              ? List.generate(
                                  discountedProducts.length,
                                  (index) => ProductCard(
                                    product: discountedProducts[index],
                                    fromHome: false,
                                    productId:
                                        discountedProducts[index].id ?? 0,
                                    title: discountedProducts[index].name ?? '',
                                    image: discountedProducts[index]
                                            .colors![0]
                                            .images![0]
                                            .url ??
                                        '',
                                  ),
                                )
                              : List.generate(
                                  discountedProducts.length,
                                  (index) => ProductCard(
                                    product: discountedProducts.reversed
                                        .toList()[index],
                                    fromHome: false,
                                    productId: discountedProducts.reversed
                                            .toList()[index]
                                            .id ??
                                        0,
                                    title: discountedProducts.reversed
                                            .toList()[index]
                                            .name ??
                                        '',
                                    image: discountedProducts.reversed
                                            .toList()[index]
                                            .colors![0]
                                            .images![0]
                                            .url ??
                                        '',
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
                const CustomAppBar(
                  title: 'عروض Amazing',
                  isOffers: true,
                  hasSeasonsDropDown: true,
                ),
                PositionedDirectional(
                  top: 48.h,
                  start: 0.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Container(
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 1),
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
              ]),
            );
          },
        );
      },
    );
  }
}
