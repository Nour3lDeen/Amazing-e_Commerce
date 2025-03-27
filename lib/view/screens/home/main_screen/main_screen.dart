import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/view/screens/brands_sceen/brands_screen.dart';
import 'package:ecommerce/view/screens/categories/offers_screen/offers_screen.dart';
import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/offers_component/offers_component.dart';
import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/start_design/start_design_component.dart';
import 'package:ecommerce/view_model/cubits/brands/brand_cubit.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../categories/category_details/category_details_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(AppAssets.back).image,
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 44.h,
                  color: AppColors.grey,
                ),
                InkWell(
                  onTap: () {
                    if (ProductsCubit.get(context).seasons.isNotEmpty) {
                      Navigation.push(context, const OffersScreen());
                    }
                  },
                  child: BlocBuilder<BottomNavCubit, BottomNavState>(
                    builder: (context, state) {
                      final bottomNavCubit = BottomNavCubit.get(context);
                      return CarouselSlider(
                        items: List.generate(bottomNavCubit.sliders.length,
                            (index) {
                          return Skeletonizer(
                            enabled: bottomNavCubit.sliders.isEmpty,
                            child: CachedNetworkImage(
                              imageUrl: bottomNavCubit.sliders[index].media
                                      ?.replaceFirst('http://', 'https://') ??
                                  '',
                              fit: BoxFit.fill,
                            ),
                          );
                        }),
                        options: CarouselOptions(
                          height: 250.h,
                          viewportFraction: 1.0,
                          reverse: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          scrollPhysics: const BouncingScrollPhysics(),
                          onPageChanged: (index, reason) {
                            // Optional: Add logic for page change
                          },
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(height: 8.h),
                ClipRRect(
                  child: InkWell(
                    onTap: () {
                      if (BrandCubit.get(context).brandsList.isNotEmpty) {
                        Navigation.push(context, const BrandsScreen());
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: BlocBuilder<BrandCubit, BrandState>(
                        builder: (context, state) {
                          final brandCubit = BrandCubit.get(context);
                          if (brandCubit.brandsList.isEmpty) {
                            return BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Skeletonizer(
                                child: CarouselSlider(
                                  items: List.generate(
                                    brandCubit.brandsList.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 6.h),
                                      child: CachedNetworkImage(
                                        imageUrl: brandCubit
                                                .brandsList[index].brand ??
                                            '',
                                        //height: 30.h,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  options: CarouselOptions(
                                    height: 60.h,
                                    viewportFraction: 0.25,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(milliseconds: 100),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 1500),
                                    autoPlayCurve: Curves.linear,
                                    reverse: true,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: CarouselSlider(
                                items: List.generate(
                                  brandCubit.brandsList.length,
                                  (index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 6.h),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          brandCubit.brandsList[index].brand ??
                                              '',
                                      //height: 30.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                options: CarouselOptions(
                                  height: 60.h,
                                  viewportFraction: 0.25,
                                  autoPlay: true,
                                  autoPlayInterval:
                                      const Duration(milliseconds: 100),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 1500),
                                  autoPlayCurve: Curves.linear,
                                  reverse: true,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const StartDesignComponent(),
                Visibility(
                  visible: ProductsCubit.get(context).everyProducts.isEmpty ||
                      ProductsCubit.get(context)
                          .everyProducts
                          .where((e) => e.sizes!.first.discountRate! > 0)
                          .toList()
                          .isNotEmpty,
                  child: OffersComponent(
                    title: 'عروض Amazing',
                    hasDiscount: true,
                    products: ProductsCubit.get(context)
                        .everyProducts
                        .where((e) => e.sizes!.first.discountRate! > 0)
                        .toList(),
                    onTap: () {
                      if (state is GetProductsLoadingState ||
                          state is SectionLoadingState ||
                          ProductsCubit.get(context).seasons.isEmpty) {
                        ProductsCubit.get(context).viewToast(
                            'جاري التحميل', context, AppColors.primaryColor);
                      } else {
                        Navigation.push(context, const OffersScreen());
                      }
                    },
                  ),
                ),
                SizedBox(height: 8.h),
                TextTitle(
                  'المنتجات الأكثر مبيعًا',
                  color: AppColors.primaryColor,
                  fontSize: 18.sp,
                ),
                Visibility(
                  visible: ProductsCubit.get(context).everyProducts.isEmpty ||
                      ProductsCubit.get(context)
                          .everyProducts
                          .where((e) => e.sectionId == 5)
                          .toList()
                          .isNotEmpty,
                  child: OffersComponent(
                    products: ProductsCubit.get(context)
                        .everyProducts
                        .where((e) => e.sectionId == 5)
                        .toList(),
                    title: 'رجالي',
                    hasDiscount: ProductsCubit.get(context)
                        .everyProducts
                        .where((e) =>
                    e.sectionId == 5 &&
                        e.sizes!.first.discountRate! > 0)
                        .toList()
                        .isNotEmpty,
                    onTap: () {
                      if (state is GetProductsLoadingState ||
                          state is SectionLoadingState) {
                        cubit.viewToast(
                            'جاري التحميل', context, AppColors.primaryColor);
                      } else {
                        cubit.categories.clear();
                        cubit.allSectionProducts.clear();
                        Navigation.push(
                          context,
                          CategoryDetailsScreen(
                            title: cubit.sections
                                    .firstWhere((e) => e.id == 5)
                                    .name ??
                                'رجالي',
                            section:
                                cubit.sections.firstWhere((e) => e.id == 5),
                          ),
                        );
                        //cubit.getAllProducts();
                        cubit.showSection(
                            cubit.sections.firstWhere((e) => e.id == 5).id ??
                                0);
                        debugPrint(
                            'Selected Category ID: ${cubit.sections.firstWhere((e) => e.id == 5).id}');
                        if (cubit.categories.isNotEmpty) {
                          cubit.selectedIndex = cubit.categories[0].id ?? 0;
                          cubit.getCategoryProduct(cubit.categories[0].id ?? 0);
                        }
                        debugPrint(
                            'products ${ProductsCubit.get(context).everyProducts.toString()}');
                      }
                    },
                  ),
                ),
                OffersComponent(
                  products: ProductsCubit.get(context)
                      .everyProducts
                      .where((e) => e.sectionId == 1)
                      .toList(),
                  title: 'نسائي',
                  hasDiscount: ProductsCubit.get(context)
                      .everyProducts
                      .where((e) =>
                          e.sectionId == 1 && e.sizes!.first.discountRate! > 0)
                      .toList()
                      .isNotEmpty,
                  onTap: () {
                    if (state is GetProductsLoadingState ||
                        state is SectionLoadingState) {
                      cubit.viewToast(
                          'جاري التحميل', context, AppColors.primaryColor);
                    } else {
                      cubit.categories.clear();
                      cubit.allSectionProducts.clear();
                      Navigation.push(
                        context,
                        CategoryDetailsScreen(
                          title: cubit.sections
                                  .firstWhere((e) => e.id == 1)
                                  .name ??
                              'نسائي',
                          section: cubit.sections.firstWhere((e) => e.id == 1),
                        ),
                      );
                      //cubit.getAllProducts();
                      cubit.showSection(
                          cubit.sections.firstWhere((e) => e.id == 1).id ?? 0);
                      debugPrint(
                          'Selected Category ID: ${cubit.sections.firstWhere((e) => e.id == 1).id}');
                      if (cubit.categories.isNotEmpty) {
                        cubit.selectedIndex = cubit.categories[0].id ?? 0;
                        cubit.getCategoryProduct(cubit.categories[0].id ?? 0);
                      }
                      debugPrint(
                          'products ${ProductsCubit.get(context).everyProducts.toString()}');
                    }
                  },
                ),
                Visibility(
                  visible: ProductsCubit.get(context).everyProducts.isEmpty ||
                      ProductsCubit.get(context)
                          .everyProducts
                          .where((e) => e.sectionId == 2)
                          .toList()
                          .isNotEmpty,
                  child: OffersComponent(
                    products: ProductsCubit.get(context)
                        .everyProducts
                        .where((e) => e.sectionId == 2)
                        .toList(),
                    title: 'أطفالي',
                    hasDiscount: ProductsCubit.get(context)
                        .everyProducts
                        .where((e) =>
                            e.sectionId == 2 &&
                            e.sizes!.first.discountRate! > 0)
                        .toList()
                        .isNotEmpty,
                    onTap: () {
                      if (state is GetProductsLoadingState ||
                          state is SectionLoadingState) {
                        cubit.viewToast(
                            'جاري التحميل', context, AppColors.primaryColor);
                      } else {
                        cubit.categories.clear();
                        cubit.allSectionProducts.clear();
                        Navigation.push(
                          context,
                          CategoryDetailsScreen(
                            title: cubit.sections
                                    .firstWhere((e) => e.id == 2)
                                    .name ??
                                'أطفالي',
                            section:
                                cubit.sections.firstWhere((e) => e.id == 2),
                          ),
                        );
                        //cubit.getAllProducts();
                        cubit.showSection(
                            cubit.sections.firstWhere((e) => e.id == 2).id ??
                                0);
                        debugPrint(
                            'Selected Category ID: ${cubit.sections.firstWhere((e) => e.id == 2).id}');
                        if (cubit.categories.isNotEmpty) {
                          cubit.selectedIndex = cubit.categories[0].id ?? 0;
                          cubit.getCategoryProduct(cubit.categories[0].id ?? 0);
                        }
                        debugPrint(
                            'products ${ProductsCubit.get(context).everyProducts.toString()}');
                      }
                    },
                  ),
                ),
                Container(height: 70.h, color: Colors.transparent),
              ],
            ),
          ),
        );
      },
    );
  }
}
