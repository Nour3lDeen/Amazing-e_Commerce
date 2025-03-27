import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/cart_item_model/cart_item_model.dart'
    as cart_item_model;
import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view/screens/cart/components/cart_counter_component/cart_counter_component.dart';
import 'package:ecommerce/view/screens/cart/order_details/order_details_screen.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../model/cart_item_model/cart_item_model.dart';
import '../../../../../view_model/cubits/cart/cart_cubit.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../categories/product_details/product_details_screen.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.cartItem, required this.productId});

  final cart_item_model.CartItems cartItem;
  final int productId;

  @override
  Widget build(BuildContext context) {
    bool hasDiscount = cartItem.size?.discountPrice != 0;
    final cubit = ProductsCubit.get(context);
    return InkWell(
      onTap: () {
        if (cartItem.orderType != 'normal') {
          String _getImageUrl(CartItems cartItem) {
            // Priority order for image URL
            if (cartItem.image?.image != null &&
                cartItem.image!.image!.isNotEmpty) {
              return cartItem.image!.image!;
            } else if (cartItem.logo?.image != null &&
                cartItem.logo!.image!.isNotEmpty) {
              return cartItem.logo!.image!;
            } else if (cartItem.customImage != null &&
                cartItem.customImage!.isNotEmpty) {
              return cartItem.customImage!;
            } else if (cartItem.example?.media != null &&
                cartItem.example!.media!.isNotEmpty) {
              return cartItem.example!.media!;
            } else {
              // Fallback to a placeholder image URL or local asset
              return 'https://via.placeholder.com/150'; // Example placeholder URL
            }
          }

          /* Navigation.push(
              context,
              ProductDetailsScreen(
                productId: productId,
                title: cartItem.product!.name!,
                product: cartItem.product!,
              ));

          ProductsCubit.get(context).sizes == cartItem.product!.sizes!;
          ProductsCubit.get(context).changeSize(cartItem.size!.sizeCode ?? '');
          debugPrint(
              'Selected Size: ${ProductsCubit.get(context).selectedSize}');
          ProductsCubit.get(context).initializeSelectedSize();
          ProductsCubit.get(context)
              .pushToStack(cartItem.product!.colors!.first.images![0].url!);
          ProductsCubit.get(context).selectedColorId = cartItem.product!.colors!.first.id!;*/
          debugPrint('total: ${cartItem.total}');
          showDialog(
            context: context,
            builder: (context) => Center(
              // Wrap the Container in a Center
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: HexColor('#E6E6E6'),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: IntrinsicHeight(
                    // Use IntrinsicHeight to constrain the Column
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // Column takes minimum space
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.lamp,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                      height: 16.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody14(
                                      'نوع عبارتك',
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.right,
                                      height: 14.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody12(
                                      cartItem.example != null
                                          ? 'أمثلة'
                                          : cartItem.name != null
                                              ? 'أسماء'
                                              : cartItem.logo != null
                                                  ? 'شعارات'
                                                  : cartItem.image != null
                                                      ? 'صور'
                                                      : 'رقم',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                if (cartItem.number != null)
                                  Container(
                                    width: 90.w,
                                    height: 110.h,
                                    padding: EdgeInsets.all(4.sp),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: AppColors.white,
                                    ),
                                    child: Center(
                                      child: TextBody14(
                                        cartItem.number.toString(),
                                        fontSize: 18.sp,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                else if (cartItem.image != null ||
                                    cartItem.logo != null ||
                                    cartItem.customImage != null ||
                                    cartItem.example != null)
                                  Container(
                                    width: 90.w,
                                    height: 110.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          _getImageUrl(cartItem),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.print,
                                      height: 16.h,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody14(
                                      'نوع الطباعة',
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.right,
                                      height: 14.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody12(
                                      cartItem.printType?.nameAr ?? '',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.sizes,
                                      height: 16.h,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody14(
                                      'مقاسات واتجاهات الطباعة',
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    cartItem.sizeDirection?.length ?? 1,
                                    (index) => Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 14.h,
                                        ),
                                        SizedBox(width: 8.w),
                                        TextBody12(
                                          cartItem.sizeDirection?[index]
                                                  .nameAr ??
                                              '',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.size,
                                      height: 16.h,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody14(
                                      'مقاس ولون المنتج',
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.right,
                                      height: 14.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody12(
                                      '${cartItem.size?.sizeCode ?? ''}',
                                    ),
                                    SizedBox(width: 32.w),
                                    Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                        color: HexColor(
                                            '${cartItem.color?.colorCode ?? ''}'),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.model,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                      height: 16.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody14(
                                      'نوع الموديل',
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.right,
                                      height: 14.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody12(
                                      cartItem.model?.nameAr ?? '',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  width: 90.w,
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          cartItem.color?.images?.first.url ??
                                              ''),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.color,
                                      height: 16.h,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody14(
                                      'لون الطباعة',
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.right,
                                      height: 14.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    Center(
                                      child: Container(
                                        width: 30.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: HexColor(
                                              '${cartItem.printColor ?? ''}'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.material,
                                      height: 16.h,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody14(
                                      'نوع الخامة',
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.right,
                                      height: 14.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    TextBody12(
                                      cartItem.material?.nameAr ?? '',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          final sizes = cartItem.product?.sizes;
          debugPrint('Product ID: $productId');
          cubit.showProduct(productId);
          if (sizes != null && sizes.isNotEmpty) {
            cubit.sizes = sizes;
            cubit.initializeSelectedSize();
          }
          cubit.initializeSelectedSize();
          cubit.sizes = [];
          cubit.pushToStack(cartItem.product?.colors?[0].images?[0].url ?? '');
          Navigation.push(
            context,
            ProductDetailsScreen(
              product: cartItem.product ?? Products(),
              productId: cartItem.product?.id ?? 0,
              title: cartItem.product?.name ?? '',
            ),
          );
        }
      },
      child: Container(
        height: 105.h,
        width: double.infinity,
        padding: EdgeInsets.only(right: 4.w, left: 8.w, bottom: 4.h, top: 4.h),
        decoration: BoxDecoration(
            color: HexColor('#DCDCDC'),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withValues(alpha: 0.5),
                blurRadius: 5,
                offset: Offset(0, 3.h),
              ),
            ]),
        child: Row(
          children: [
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(cartItem
                          .color?.images![0].url ??
                      'https://sharidah.sa/ecom/backend/public/storage/1121/961.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                spacing: 6.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextBody14(
                          cartItem.product?.name ?? 'هودي بسوستة',
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextDescription(
                        '(${cartItem.product?.rate})',
                      ),
                      SvgPicture.asset(AppAssets.star),
                    ],
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: hasDiscount && cartItem.orderType == 'normal',
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Text('${cartItem.size?.basicPrice ?? 0} ر.س',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Lamar',
                                  fontSize: 10.sp,
                                  color: AppColors.red.withValues(alpha: 0.7),
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor:
                                      AppColors.red.withValues(alpha: 0.8),
                                  decorationThickness: 1.5,
                                )),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !hasDiscount,
                        replacement: TextBody12(
                          '${cartItem.size?.discountPrice ?? 0} ر.س',
                          color: AppColors.black,
                        ),
                        child: TextBody12(
                          cartItem.orderType == 'normal'
                              ? '${cartItem.size?.basicPrice ?? 0} ر.س'
                              : '${cartItem.total ?? 0} ر.س',
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: hasDiscount && cartItem.orderType == 'normal',
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 1.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                gradient: LinearGradient(
                                  colors: [
                                    HexColor('#FD6C6C'),
                                    HexColor('#B84141'),
                                  ],
                                )),
                            child: TextBody12(
                              'خصم ${cartItem.size?.discountRate ?? 0}%',
                              color: AppColors.white,
                            )),
                      )
                    ],
                  ),
                  Row(children: [
                    TextBody12(
                      'اللون',
                      color: AppColors.black,
                    ),
                    SizedBox(width: 40.w),
                    Container(
                      height: 16.h,
                      width: 16.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: HexColor(
                            cartItem.color?.colorCode ?? '#000000',
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: Offset(0, 3.h),
                            )
                          ]),
                    ),
                    const Spacer(),
                    CartCounterComponent(
                      productId: productId,
                      cartItem: cartItem,
                      productCount: int.tryParse('${cartItem.quantity}') ?? 0,
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextBody12('المقاس'),
                      SizedBox(width: 30.w),
                      TextBody12(cartItem.size?.sizeCode ?? 'XL'),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Container(
                                  width: 240.w,
                                  height: 160.h,
                                  padding: EdgeInsets.all(12.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                    image: DecorationImage(
                                      image: Image.asset(
                                              AppAssets.containerBackground)
                                          .image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.error_outline_rounded,
                                        color: AppColors.red,
                                        size: 50.sp,
                                      ),
                                      TextBody14(
                                        'سيتم حذف المنتج \nهل أنت متأكد؟',
                                        color: AppColors.black,
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomButton(
                                            onPressed: () {
                                              CartCubit.get(context)
                                                  .deleteCartItem(
                                                context,
                                                cartItem.id!,
                                              );
                                              Navigator.pop(
                                                  context); // Close the dialog after action
                                            },
                                            gradient: LinearGradient(colors: [
                                              HexColor(
                                                '#DA6A6A',
                                              ),
                                              HexColor(
                                                '#B20707',
                                              )
                                            ]),
                                            borderRadius: 8.r,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.h),
                                              child: SizedBox(
                                                width: 95.w,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    TextBody12(
                                                      'حذف',
                                                      color: AppColors.white,
                                                    ),
                                                    SizedBox(width: 4.w),
                                                    SvgPicture.asset(
                                                      AppAssets.delete,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          CustomButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            backgroundColor: AppColors.white,
                                            child: Container(
                                              width: 95.w,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.h),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  border: Border.all(
                                                      color: AppColors.red)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextBody12(
                                                    'إلغاء',
                                                    color: AppColors.red,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Icon(
                                                    Icons.cancel_outlined,
                                                    color: AppColors.red,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              gradient: LinearGradient(
                                begin: AlignmentDirectional.topCenter,
                                end: AlignmentDirectional.bottomCenter,
                                colors: [
                                  HexColor('#CA4F4F'),
                                  HexColor('#FF9090'),
                                ],
                              )),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextBody12('إزالة', color: AppColors.white),
                              SvgPicture.asset(
                                AppAssets.close,
                                height: 14.h,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  //SizedBox(height: 4.h),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
