import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import '../../../../../../view_model/cubits/products/products_cubit.dart';
import '../../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../../../../view_model/utils/navigation/navigation.dart';
import '../../../../categories/product_details/product_details_screen.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return FloatingSearchBar(
          controller: FloatingSearchBarController(),
          backgroundColor: AppColors.white.withAlpha(100),
          leadingActions: [
            SvgPicture.asset(
              AppAssets.search,
              height: 14.h,
              width: 14.w,
            ),
          ],
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
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          width: 175.w,
          height: 28.h,
          openAxisAlignment: 0.0,
          backdropColor: Colors.transparent,
          debounceDelay: const Duration(milliseconds: 200),
          onQueryChanged: (query) {
            ProductsCubit.get(context).updateSearchQuery(
                query);
            debugPrint('Search Query: $query');
          },
          transition: CircularFloatingSearchBarTransition(),
          actions: const [],
          builder: (context, transition) {
            final cubit = ProductsCubit.get(context);


            final filteredProducts = cubit.searchQuery.isNotEmpty
                ? cubit.everyProducts
                .where((product) =>
                product.name!
                    .toLowerCase()
                    .contains(cubit.searchQuery.toLowerCase()))
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
                          (index) =>
                          ListTile(
                            title: TextBody14(
                                filteredProducts[index].name!),
                            onTap: () {
                              debugPrint('filteredProducts: ${filteredProducts}');
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
        );
      },
    );
  }
}
