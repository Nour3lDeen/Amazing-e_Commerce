import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/offers_component/product_card.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OffersComponent extends StatelessWidget {
  const OffersComponent({
    super.key,
    required this.title,
    required this.hasDiscount,
    required this.onTap,
    this.products = const [],
  });

  final bool hasDiscount;
  final String title;
  final List<Products> products;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
      //  hasDiscount=products.where((x) => x.sizes![0].discountPrice! < 0).isNotEmpty;
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h, right: 16.w, left: 16.w),
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: GestureDetector(
                  onTap: onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextTitle(
                        title,
                        color: AppColors.black,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          TextBody14(
                            'المزيد...',
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.grey,
                            size: 12.sp,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Product List or Skeleton Loader
              Align(
                alignment: Alignment.centerRight,
                child: Skeletonizer(
                  enabled: products.isEmpty,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: Row(
                      children: List.generate(
                        products.isNotEmpty ? (products.length >= 6 ? 6 : products.length) : 6,
                            (index) {
                          final bool isPlaceholder = products.isEmpty;
                          final Products product = isPlaceholder
                              ? Products(id: 0, name: '', colors: [])
                              : products[index];

                          return Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: ProductCard(
                              product: product,
                              title: product.name ?? 'قميص كاروهات',
                              image: (product.colors?.isNotEmpty ?? false) &&
                                  (product.colors![0].images?.isNotEmpty ?? false)
                                  ? product.colors![0].images![0].url ?? ''
                                  : 'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                              fromHome: isPlaceholder,
                              productId: product.id ?? 0,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
