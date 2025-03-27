import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view/common_components/seasons_drop_down/seasons_drop_down.dart';
import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/offers_component/product_card.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import '../../../../view_model/cubits/products/products_cubit.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../../view_model/utils/navigation/navigation.dart';
import '../product_details/product_details_screen.dart';
import 'components/filter_header.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen(
      {super.key, required this.title, required this.section});

  final String title;
  final Section section;

  /// todo transform the search bar to up
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Main Content
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(AppAssets.back).image,
                fit: BoxFit.cover,
              ),
            ),
            child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                context
                    .read<ProductsCubit>()
                    .updateScrollOffset(scrollController.offset);
              }
              return false;
            }, child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                final cubit = ProductsCubit.get(context);
                List<Products> filteredProducts = cubit.allSectionProducts
                    .where((e) =>
                        (e.categoryId == cubit.selectedIndex) &&
                        (cubit.selectedIndexSeason == -1 ||
                            e.seasonId == cubit.selectedSeasonId))
                    .toList();
                if (state is SectionLoadingState) {
                  return Center(
                      child: LoadingAnimationWidget.inkDrop(
                    color: AppColors.primaryColor,
                    size: 30.sp,
                  ));
                }
                if (state is ProductsLoadingState) {
                  return ListView(
                    clipBehavior: Clip.none,
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 120.h, bottom: 32.h),
                    children: [
                      // Horizontal scroll for categories
                      SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 4.w,
                          children: List.generate(
                            cubit.categories.length,
                            (index) => FilterHeader(
                              index: cubit.categories[index].id!,
                              title: cubit.categories[index].name!,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 230.h),

                      LoadingAnimationWidget.inkDrop(
                        color: AppColors.primaryColor,
                        size: 30.sp,
                      )
                    ],
                  );
                }

                // Check if products have successfully loaded
                if (state is ProductsSuccessState) {
                  return ListView(
                    clipBehavior: Clip.none,
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 120.h, bottom: 32.h),
                    children: [
                      // Horizontal scroll for categories
                      SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 4.w,
                          children: List.generate(
                            cubit.categories.length,
                            (index) => FilterHeader(
                              index: cubit.categories[index].id!,
                              title: cubit.categories[index].name!,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 16.h,
                        runSpacing: 16.h,
                        children: List.generate(
                          filteredProducts.length,
                          (index) => ProductCard(
                            product: filteredProducts[index],
                            title: filteredProducts[index].name!,
                            image: filteredProducts[index]
                                .colors![0]
                                .images![0]
                                .url!,
                            fromHome: false,
                            productId: filteredProducts[index].id!,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // If no success state is reached, show a fallback UI
                return ListView(
                  clipBehavior: Clip.none,
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 120.h, bottom: 32.h),
                  children: [
                    // Horizontal scroll for categories
                    SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 4.w,
                        children: List.generate(
                          cubit.categories.length,
                          (index) => FilterHeader(
                            index: cubit.categories[index].id!,
                            title: cubit.categories[index].name!,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Visibility(
                      visible: filteredProducts.isNotEmpty,
                      replacement: Column(
                        children: [
                          SizedBox(height: 200.h),
                          TextTitle('لا يوجد منتجات', color: AppColors.black),
                        ],
                      ),
                      child: Wrap(
                        spacing: 16.h,
                        runSpacing: 16.h,
                        children: List.generate(
                          filteredProducts.length,
                          (index) => ProductCard(
                            product: filteredProducts[index],
                            title: filteredProducts[index].name!,
                            image: filteredProducts[index]
                                .colors![0]
                                .images![0]
                                .url!,
                            fromHome: false,
                            productId: filteredProducts[index].id!,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
          ),

          // Back Icon and Search Bar
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              bool isScrolledDown = false;

              if (state is ProductsScrollState) {
                isScrolledDown = state.isScrolledDown;
              }

              return Visibility(
                visible: isScrolledDown,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: isScrolledDown ? 50.h : 40.h,
                    left: 12.w,
                    right: 12.w,
                  ),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      AppAssets.backIcon,
                      height: 32.h,
                      width: 32.w,
                    ),
                  ),
                ),
              );
            },
          ),

          // Floating Search Bar
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              bool android =
                  SharedHelper.getData(SharedKeys.platform) == 'android';
              bool isScrolledDown = false;

              if (state is ProductsScrollState) {
                isScrolledDown = state.isScrolledDown;
              }

              return Padding(
                padding: EdgeInsets.only(
                  top: isScrolledDown && android
                      ? 8.h
                      : isScrolledDown && !android
                          ? 0.h
                          : android
                              ? 40.h
                              : 28.h,
                  right: isScrolledDown ? 32.w : 16.w,
                  left: isScrolledDown ? 0.w : 16.w,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FloatingSearchBar(
                    transition: CircularFloatingSearchBarTransition(),
                    actions: const [],
                    backgroundColor: AppColors.white.withAlpha(100),
                    borderRadius: BorderRadius.circular(24.r),
                    hint: 'بحث عن منتج',
                    queryStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11.sp,
                      fontFamily: 'Lamar',
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11.sp,
                      fontFamily: 'Lamar',
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    transitionCurve: Curves.easeInOut,
                    physics: const BouncingScrollPhysics(),
                    width: isScrolledDown ? 290.w : 500.w,
                    height: isScrolledDown ? 28.h : 32.h,
                    backdropColor: Colors.transparent,
                    debounceDelay: const Duration(milliseconds: 200),
                    onQueryChanged: (query) {
                      ProductsCubit.get(context).updateSearchQuery(query);
                      debugPrint('Search Query: $query');
                    },
                    leadingActions: [
                      SvgPicture.asset(
                        AppAssets.search,
                        height: isScrolledDown ? 14.h : 14.h,
                        width: isScrolledDown ? 14.w : 14.w,
                      ),
                      SizedBox(width: 6.w),
                    ],
                    automaticallyImplyBackButton: false,
                    builder: (context, transition) {
                      final cubit = ProductsCubit.get(context);

                      final filteredProducts = cubit.searchQuery.isNotEmpty
                          ? cubit.allProducts
                              .where((product) =>
                                  (product.name!.toLowerCase().contains(
                                      cubit.searchQuery.toLowerCase())) &&
                                  product.sectionId == section.id)
                              .toList()
                          : [];

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Material(
                            color: Colors.white.withAlpha(240),
                            // Slight transparency
                            elevation: 4.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: filteredProducts.isEmpty
                                  ? [
                                      Padding(
                                        padding: EdgeInsets.all(16.sp),
                                        child: TextBody12(
                                          cubit.searchQuery.isEmpty
                                              ? 'البحث عن منتج'
                                              : 'لا يوجد منتجات بحث مطابقة',
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ]
                                  : List.generate(
                                      filteredProducts.length,
                                      (index) => ListTile(
                                        title: TextBody14(
                                            filteredProducts[index].name!),
                                        onTap: () {
                                          debugPrint(
                                              'Product ID: ${filteredProducts[index].id}');
                                          cubit.showProduct(
                                              filteredProducts[index].id);
                                          if (filteredProducts[index].sizes !=
                                                  null &&
                                              filteredProducts[index]
                                                  .sizes
                                                  .isNotEmpty) {
                                            cubit.sizes =
                                                filteredProducts[index].sizes;
                                            cubit.initializeSelectedSize();
                                          }
                                          cubit.initializeSelectedSize();
                                          cubit.sizes = [];
                                          cubit.pushToStack(
                                              filteredProducts[index]
                                                  .colors![0]
                                                  .images![0]
                                                  .url!);
                                          Navigation.push(
                                            context,
                                            ProductDetailsScreen(
                                              productId:
                                                  filteredProducts[index].id!,
                                              title:
                                                  filteredProducts[index].name!,
                                              product: filteredProducts[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            )),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          // Back Icon and Title at Top
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              bool isScrolledDown = false;

              if (state is ProductsScrollState) {
                isScrolledDown = state.isScrolledDown;
              }

              if (!isScrolledDown) {
                return Positioned(
                  top: 40.h,
                  left: 16.w,
                  right: 16.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          AppAssets.backIcon,
                          height: 32.h,
                          width: 32.w,
                        ),
                      ),
                      const SizedBox.shrink(),
                      Hero(
                        tag: title,
                        child: Material(
                          type: MaterialType.transparency,
                          child: TextTitle(
                            title,
                            color: AppColors.primaryColor,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      const SeasonsDropDown()
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
