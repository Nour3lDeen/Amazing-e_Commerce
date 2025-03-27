import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/offers_component/product_card.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../view_model/cubits/brands/brand_cubit.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';
import '../../common_components/custom_app_bar/custom_app_bar.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.back),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<BrandCubit, BrandState>(
              builder: (context, state) {
                final cubit = BrandCubit.get(context);
                return ListView(
                    padding: EdgeInsets.only(top: 90.h),
                    clipBehavior: Clip.none,
                    controller: cubit.scrollController,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.translate(
                            offset: Offset(0, -12.h),
                            child: InkWell(
                              onTap: cubit.nextPage,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20.sp,
                                color: AppColors.primaryColor,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.25),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 75.w,
                            height: 80.h,
                            child: CarouselSlider(
                              // disableGesture: true,
                              carouselController: cubit.carouselController,
                              items: List.generate(
                                cubit.brandsList.length,
                                (index) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cubit.setPage(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: index == cubit.currentIndex
                                              ? Border.all(
                                                  color: HexColor('#71FAE3'),
                                                  width: 2,
                                                )
                                              : Border.all(
                                                  color: AppColors.white,
                                                  width: 1.5,
                                                ),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          boxShadow: index == cubit.currentIndex
                                              ? [
                                                  BoxShadow(
                                                    color: HexColor('#39FAD9')
                                                        .withValues(alpha: 0.2),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 5.h),
                                                  ),
                                                ]
                                              : [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(
                                                            alpha: 0.25),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: 50.h,
                                                width: 90.w,
                                                child: CachedNetworkImage(
                                                  imageUrl: cubit
                                                          .brandsList[index]
                                                          .brand ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              if (index != cubit.currentIndex)
                                                Positioned.fill(
                                                  child: Container(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.6),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    TextBody14(
                                      '${cubit.brandsList[index].name ?? ''}',
                                      color: index == cubit.currentIndex
                                          ? AppColors.black
                                          : AppColors.black,
                                      fontWeight: index == cubit.currentIndex
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                              options: CarouselOptions(
                                // scrollPhysics: const BouncingScrollPhysics(),
                                viewportFraction: 0.25.w,
                                reverse: true,
                                enlargeCenterPage: true,
                                initialPage: cubit.currentIndex,
                                onPageChanged: (index, reason) {
                                  cubit.setPage(index);
                                  debugPrint(
                                      'brand id ${cubit.brandsList[cubit.currentIndex].id}');
                                },
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(-3.w, -12.h),
                            child: InkWell(
                              onTap: () {
                                cubit.previousPage();
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20.sp,
                                color: AppColors.primaryColor,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.25),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      BlocBuilder<ProductsCubit, ProductsState>(
                        builder: (context, state) {
                          final productsCubit = ProductsCubit.get(context);
                          final categories = productsCubit.allCategories
                              .where((e) =>
                                  e.sectionId == cubit.currentSectionId)
                              .toList();

                          return Column(
                            children: [
                              Center(
                                child: DropdownButton(
                                  items: List.generate(
                                      productsCubit.sections.length,
                                      (index) => DropdownMenuItem(
                                            value: index,
                                            child: TextBody14(
                                              productsCubit
                                                      .sections[index].name ??
                                                  '',
                                              color: AppColors.black,
                                            ),
                                          )),
                                  onChanged: (value) {
                                    cubit.changeSection(value!, context);
                                    cubit.changeCategory(
                                        -1, cubit.currentSectionId, context);
                                  },
                                  hint: Container(
                                    height: 28.h,
                                    width: 128.w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      gradient: LinearGradient(
                                        colors: [
                                          HexColor('#31D3C6'),
                                          HexColor('#208B78'),
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextBody14(
                                          productsCubit
                                                  .sections[
                                                      cubit.currentSectionIndex]
                                                  .name ??
                                              '',
                                          color: AppColors.white,
                                        ),
                                        SizedBox(width: 4.w),
                                        SvgPicture.asset(
                                          AppAssets.arrowDown,
                                          height: 10.h,
                                          width: 10.w,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  iconSize: 0,

                                  dropdownColor: Colors.white,
                                  underline: const SizedBox.shrink(),
                                  borderRadius: BorderRadius.circular(8.r),
                                  //isExpanded: true,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              SingleChildScrollView(
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(16.r),
                                      onTap: () {
                                        cubit.changeCategory(-1,
                                            cubit.currentSectionId, context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 8.sp),
                                        decoration: BoxDecoration(
                                          gradient:
                                              cubit.currentCategoryIndex == -1
                                                  ? LinearGradient(colors: [
                                                      HexColor('#49F2D5'),
                                                      HexColor('#09AC90'),
                                                    ])
                                                  : null,
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: TextBody12(
                                            'جميع المنتجات',
                                            color:
                                                cubit.currentCategoryIndex == -1
                                                    ? AppColors.white
                                                    : AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Row(
                                      spacing: 4.w,
                                      children: List.generate(
                                          categories.length,
                                          (index) => InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                                onTap: () {
                                                  cubit.changeCategory(
                                                      index,
                                                      cubit.currentSectionId,
                                                      context);
                                                  debugPrint(
                                                      'category id: ${cubit.currentCategoryId}');
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.w,
                                                      vertical: 8.sp),
                                                  decoration: BoxDecoration(
                                                    gradient: index ==
                                                            cubit
                                                                .currentCategoryIndex
                                                        ? LinearGradient(
                                                            colors: [
                                                                HexColor(
                                                                    '#49F2D5'),
                                                                HexColor(
                                                                    '#09AC90'),
                                                              ])
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: TextBody12(
                                                      categories[index].name ??
                                                          '',
                                                      color: index ==
                                                              cubit
                                                                  .currentCategoryIndex
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              BlocBuilder<ProductsCubit, ProductsState>(
                                buildWhen: (previous, current) =>
                                    current is ChangeCategoryState,
                                builder: (context, state) {
                                  final brandCubit = BrandCubit.get(context);
                                  final productsCubit =
                                      ProductsCubit.get(context);

                                  final products = productsCubit.everyProducts
                                      .where((e) =>
                                          (brandCubit.currentCategoryIndex ==
                                                  -1 ||
                                              e
                                                      .categoryId ==
                                                  brandCubit
                                                      .currentCategoryId) &&
                                          e
                                                  .sectionId ==
                                              productsCubit
                                                  .sections[brandCubit
                                                      .currentSectionIndex]
                                                  .id &&
                                          (productsCubit.selectedIndexSeason ==
                                                  -1 ||
                                              e.seasonId ==
                                                  productsCubit
                                                      .selectedIndexSeason) &&
                                          e.brandId ==
                                              brandCubit
                                                  .brandsList[
                                                      brandCubit.currentIndex]
                                                  .id)
                                      .toList();
                                  if (products.isEmpty) {
                                    return Center(
                                      child: TextTitle(
                                        'لا يوجد منتجات',
                                        color: AppColors.black,
                                      ),
                                    );
                                  } else {
                                    return Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 16.w,
                                      runSpacing: 16.h,
                                      children: List.generate(
                                        products.length,
                                        (index) => ProductCard(
                                          product: products[index],
                                          productId: products[index].id ?? 0,
                                          title: products[index].name ?? '',
                                          image: products[index]
                                                  .colors
                                                  ?.first
                                                  .images
                                                  ?.first
                                                  .url ??
                                              'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                                          fromHome: false,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ]);
              },
            ),
          ),
          const CustomAppBar(
            title: 'علاماتنا التجارية',
            isOffers: false,
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
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
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
        ],
      ),
    );
  }
}
