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
    required this.productId,
    required this.hasDiscount,
    required this.title,
    required this.image,
    required this.fromHome,
  });

  final int productId;
  final bool hasDiscount;
  final String title;
  final String image;
  final bool fromHome;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);
        // Find the product once and reuse it

        final product = cubit.products.firstWhere(
          (product) => product.id == productId,
          orElse: () => Products(id: productId),
        );
        String? imageUrl;
        final sizes = product.sizes;
        final colors = product.colors;
        if (!fromHome) {
          imageUrl = colors![0].images!.isNotEmpty == true
              ? colors[0].images![0].url
              : '';
        }

        return InkWell(
          onTap: () {
            if (fromHome == false) {
              {
                debugPrint('Product ID: $productId');
                cubit.showProduct(productId);
                if (sizes != null && sizes.isNotEmpty) {
                  cubit.sizes = sizes;
                  cubit.initializeSelectedSize();
                }

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
                  fromHome ? image : imageUrl!,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBody12(
                                  title,
                                  textAlign: TextAlign.center,
                                  fontSize: 12.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  spacing: 2.w,
                                  children: [
                                    TextDescription(
                                      'الألوان: ',
                                      textAlign: TextAlign.center,
                                      fontSize: 10.sp,
                                    ),
                                    const Spacer(),
                                    Row(
                                      spacing: 4.w,
                                      children: List.generate(
                                        fromHome == true
                                            ? 3
                                            : colors?.length ?? 3,
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
                                              color: fromHome == true
                                                  ? HexColor('#EFEFEF')
                                                  : HexColor(colors?[index]
                                                          .colorCode ??
                                                      ''),
                                              shape: BoxShape.circle,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextBody14('السعر:',
                                        textAlign: TextAlign.center,
                                        fontSize: 10.sp),
                                    const Spacer(),
                                    Visibility(
                                      visible: /*sizes != null &&
                                          sizes.isNotEmpty &&
                                          sizes[0].discountPrice != '0'*/
                                          hasDiscount,
                                      child: Text(
                                        hasDiscount
                                            ? '30 ر.س'
                                            : '${sizes?[0].basicPrice} ر.س',
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
                                      fromHome
                                          ? '20 ر.س'
                                          : sizes != null &&
                                                  sizes.isNotEmpty &&
                                                  sizes[0].discountPrice != '0'
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
                  buildWhen: (previous, current) =>
                      current is ChangeFavoriteState &&
                      current.productId == productId,
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
                                barrierDismissible: true,
                                builder: (ctx) {
                                  return NotLoggedComponent();
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
                  child: _buildDiscountBadge(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Discount Badge Widget
  Widget _buildDiscountBadge(BuildContext context) {
    return Visibility(
      visible: /*(ProductsCubit.get(context)
              .products
              .where((x) => x.id == productId)
              .first
              .sizes![0]
              .discountPrice! !=
          '0')||*/
          hasDiscount,
      child: Container(
        width: 120.w,
        height: 60.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AppAssets.discount).image,
            colorFilter: ColorFilter.mode(
                Colors.red.withValues(alpha: 0.8), BlendMode.srcIn),
            isAntiAlias: false,
          ),
        ),
        child: Center(
          child: Transform.rotate(
            angle: 45 * (3.141592653589793 / 180),
            child: TextTitle(
              /* 'خصم ${ProductsCubit.get(context).products.where((x) => x.id == productId).first.sizes![0].discountRate}%'*/
              'خصم 20%',
              color: AppColors.white,
              fontSize: 9.sp,
            ),
          ),
        ),
      ),
    );
  }
}
