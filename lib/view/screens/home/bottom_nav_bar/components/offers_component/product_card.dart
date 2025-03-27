import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../../model/sections_model/sections_model.dart';
import '../../../../../../view_model/cubits/products/products_cubit.dart';
import '../../../../../../view_model/data/local/shared_helper.dart';
import '../../../../../../view_model/data/local/shared_keys.dart';
import '../../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../common_components/not_logged_component/not_logged_component.dart';
import '../../../../categories/product_details/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.productId,
    required this.title,
    required this.image,
    required this.fromHome,
  });

  final Products product;
  final int productId;
  final String title;
  final String image;
  final bool fromHome;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        bool hasDiscount = product.sizes?.first.discountRate! != 0;
        final cubit = ProductsCubit.get(context);
        // Find the product once and reuse it

        /* final product = cubit.products.firstWhere(
          (product) => product.id == productId,
          orElse: () => Products(id: productId),
        );
        //String? imageUrl;*/
        final sizes = product.sizes;
        final colors = product.colors ?? [];
        /*if (!fromHome) {
          imageUrl = colors![0].images!.isNotEmpty == true
              ? colors[0].images![0].url
              : '';
        }*/

        return InkWell(
          onTap: () {
            if (fromHome == false) {
              {
                debugPrint('Product ID: $productId');
                debugPrint('Product category ID: ${product.categoryId}');
                cubit.showProduct(productId);
                if (sizes != null && sizes.isNotEmpty) {
                  cubit.sizes = sizes;
                  cubit.initializeSelectedSize();
                }
                cubit.initializeSelectedSize();
                cubit.sizes = [];
                cubit.pushToStack(image);
                Navigation.push(
                  context,
                  ProductDetailsScreen(
                    product: product,
                    productId: productId,
                    title: title,
                  ),
                );
              }
            }
          },
          child: Container(
            height: 170.h,
            width: 154.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  fromHome
                      ? image.replaceFirst('http://', 'https://')
                      : product.colors?[0].images?[0].url ??
                          'https://img.freepik.com/photos-gratuite/iguane-jaune-gros-plan-visage-iguane-albinos-gros-plan_488145-3482.jpg?t=st=1742817188~exp=1742820788~hmac=7c1d0ef9f488f3613d3b8042e3914692fcaf17b5c84b33c95cceb96a1a3e737a&w=996'
                              .replaceFirst('http://', 'https://'),
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Transform.translate(
                    offset: Offset(0, 0.5.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.r),
                        bottomRight: Radius.circular(8.r),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: 55.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                            color: HexColor('#EFEFEF').withValues(alpha: 0.7),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 8.w),
                            child: Column(
                              spacing: 2.h,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBody12(
                                  title,
                                  textAlign: TextAlign.center,
                                  fontSize: 12.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Wrap(children: [
                                  Row(
                                    spacing: 2.w,
                                    children: [
                                      TextDescription(
                                        'الألوان: ',
                                        textAlign: TextAlign.center,
                                        fontSize: 10.sp,
                                      ),
                                      const Spacer(),
                                      Visibility(
                                          visible:
                                              !fromHome && colors.length > 5,
                                          child: TextDescription(
                                            '${colors.length - 5}+',
                                          )),
                                      Row(
                                        spacing: 4.w,
                                        children: List.generate(
                                          colors.length > 5 ? 5 : colors.length,
                                          (index) {
                                            return Container(
                                              width: 12.w,
                                              height: 12.h,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withValues(alpha: 0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                                color: HexColor(
                                                    colors[index].colorCode ??
                                                        ''),
                                                shape: BoxShape.circle,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                Row(
                                  children: [
                                    TextBody14('السعر:',
                                        textAlign: TextAlign.center,
                                        fontSize: 10.sp),
                                    const Spacer(),
                                    Visibility(
                                      visible: hasDiscount,
                                      child: Text(
                                        '${sizes?[0].basicPrice} ر.س',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Lamar',
                                          fontSize: 8.sp,
                                          color:
                                              Colors.red.withValues(alpha: 0.7),
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor:
                                              Colors.red.withValues(alpha: 0.8),
                                          decorationThickness: 1.5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    TextBody14(
                                      hasDiscount
                                          ? '${sizes?[0].discountPrice} ر.س'
                                          : sizes != null &&
                                                  sizes.isNotEmpty &&
                                                  sizes[0].discountPrice! < 0
                                              ? '${sizes[0].discountPrice} ر.س'
                                              : '${sizes?[0].basicPrice} ر.س',
                                      textAlign: TextAlign.center,
                                      fontSize: 10.sp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    final cubit = ProductsCubit.get(context);
                    final isFavorite = cubit.isProductFavorite(productId);
                    return GestureDetector(
                      onTap: () {
                        cubit.toggleFavorite(productId, context);
                      },
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: GestureDetector(
                          onTap: () {
                            if (SharedHelper.getData(SharedKeys.token) !=
                                null) {
                              cubit.toggleFavorite(productId, context);
                              debugPrint('favourite clicked');
                            } else {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return const NotLoggedComponent();
                                },
                              );
                            }
                          },
                          child: AnimatedScale(
                            scale: isFavorite ? 1.2 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black
                                          .withValues(alpha: 0.10),
                                      blurRadius: 10,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.heart,
                                  colorFilter: isFavorite
                                      ? ColorFilter.mode(
                                          HexColor('#FF5555'), BlendMode.srcIn)
                                      : null,
                                  height: 16.h,
                                  width: 16.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Discount Badge
                PositionedDirectional(
                  top: -15.h,
                  start: -35.w,
                  child: _buildDiscountBadge(context, sizes: sizes),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Discount Badge Widget
  Widget _buildDiscountBadge(BuildContext context,
      {required List<Sizes>? sizes}) {
    return Visibility(
      visible: /*(ProductsCubit.get(context)
              .products
              .where((x) => x.id == productId)
              .first
              .sizes![0]
              .discountPrice! !=
          '0')||*/
          //hasDiscount,
          product.sizes?.first.discountRate! != 0,
      child: Container(
        width: 120.w,
        height: 60.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AppAssets.discount).image,
            colorFilter: ColorFilter.mode(
                Colors.red.withValues(alpha: 0.8), BlendMode.srcIn),
          ),
        ),
        child: Center(
          child: Transform.rotate(
            angle: 45 * (3.141592653589793 / 180),
            child: TextTitle(
              'خصم ${sizes?[0].discountRate}%',
              color: AppColors.white,
              shadows: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                )
              ],
              fontSize: 9.sp,
            ),
          ),
        ),
      ),
    );
  }
}
