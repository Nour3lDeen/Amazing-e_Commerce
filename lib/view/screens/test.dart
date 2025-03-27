import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/offers_component/product_card.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../view_model/cubits/products/products_cubit.dart';
import '../../view_model/utils/navigation/navigation.dart';
import 'categories/product_details/product_details_screen.dart';

class ScrollScreen extends StatelessWidget {
  const ScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProductsCubit, ProductsState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width:double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.back),
            fit: BoxFit.cover,
          ),
        ),
        
        child: ListView(
          children: [
            SizedBox(
              height: 800.h,

              child: FloatingSearchBar(
                transition: CircularFloatingSearchBarTransition(),
                actions: const [],
                backgroundColor: AppColors.white.withAlpha(100), // Adjust transparency
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
                //width:500.w,
                height: 32.h,
                backdropColor: Colors.transparent,
                debounceDelay: const Duration(milliseconds: 200),
                onQueryChanged: (query) {
                  ProductsCubit.get(context).updateSearchQuery(query); // Update the cubit's search query
                  debugPrint('Search Query: $query');
                },
                leadingActions: [
                  SvgPicture.asset(
                    AppAssets.search,
                    height:14.h,
                    width: 14.w,
                  ),
                  SizedBox(width: 6.w),
                ],
                automaticallyImplyBackButton: false,
                builder: (context, transition) {
                  final cubit = ProductsCubit.get(context);

                  // Filter products based on the current search query
                  final filteredProducts = cubit.searchQuery.isNotEmpty
                      ? cubit.allProducts
                      .where((product) => product.name!
                      .toLowerCase()
                      .contains(cubit.searchQuery.toLowerCase()))
                      .toList()
                      : [];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Material(
                        color: Colors.white.withAlpha(240), // Slight transparency
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
                              title: TextBody14(filteredProducts[index].name!),
                              onTap: () {
                                cubit.pushToStack(
                                  filteredProducts[index].colors![0].images![0].url!,
                                );
                                Navigation.push(
                                  context,
                                  ProductDetailsScreen(
                                    productId: filteredProducts[index].id!,
                                    title: filteredProducts[index].name!,
                                    product: filteredProducts[index],
                                  ),
                                );
                                debugPrint('Product: ${filteredProducts[index].name}');
                              },
                            ),
                          ),
                        )

                    ),
                  );
                },
              ),
            )
            ]
        ),
    ),
    );
  },
);
  }
}
