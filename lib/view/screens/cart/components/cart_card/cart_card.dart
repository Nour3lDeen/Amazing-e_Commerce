import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/cart_item_model/cart_item_model.dart'
    as cart_item_model;
import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view/screens/cart/components/cart_counter_component/cart_counter_component.dart';
import 'package:ecommerce/view/screens/cart/order_details/order_details_screen.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../view_model/cubits/cart/cart_cubit.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../categories/product_details/product_details_screen.dart';

class CartCard extends StatelessWidget {
  const CartCard(
      {super.key,
      required this.isHistory,
      required this.cartItem,
      required this.productId});

  final cart_item_model.CartItem cartItem;
  final bool isHistory;
  final int productId;

  @override
  Widget build(BuildContext context) {
    bool hasDiscount = false;
    return InkWell(
      onTap: () {
        if (!isHistory) {
          Navigation.push(
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
              .pushToStack(cartItem.color!.images![0].url!);
          ProductsCubit.get(context).selectedColorId = cartItem.color!.id!;
        }else{
          Navigation.push(context, OrderDetailsScreen());
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
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
                image: DecorationImage(
                  image: isHistory
                      ? Image.asset(AppAssets.section4).image
                      : CachedNetworkImageProvider(
                          cartItem.color!.images![0].url!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                spacing: 4.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      TextBody12(
                        cartItem.product?.name ?? 'هودي بسوستة',
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: SvgPicture.asset(AppAssets.star),
                          );
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: hasDiscount,
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
                      TextBody12(
                        '${cartItem.size?.basicPrice ?? 0} ر.س',
                        color: AppColors.black,
                      ),
                      const Spacer(),
                      Visibility(
                        visible: hasDiscount,
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
                    Visibility(
                        visible: isHistory,
                        child: TextBody12(
                          'العدد : ${cartItem.quantity ?? 0} قطع',
                          fontSize: 10.sp,
                        )),
                    Visibility(
                        visible: !isHistory,
                        child: CartCounterComponent(
                          productId: productId,
                          productCount:
                              int.tryParse(cartItem.quantity ?? '') ?? 0,
                          cart: true,
                        )),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextBody12('المقاس'),
                      SizedBox(width: 30.w),
                      TextBody12(cartItem.size?.sizeCode ?? 'XL'),
                      const Spacer(),
                      Visibility(
                          visible: isHistory,
                          child: TextBody12(
                            'التاريخ : ${cartItem.createdAt ?? '12/12/2024'}',
                            fontSize: 10.sp,
                          )),
                      Visibility(
                        visible: !isHistory,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
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
                                                        color: AppColors.red,
                                                        width: 1)),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextBody12('إزالة', color: AppColors.white),
                                SvgPicture.asset(
                                  AppAssets.close,
                                  height: 14.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  //SizedBox(height: 4.h),
                  Visibility(
                    visible: isHistory,
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBody12('حالة الطلب : ', color: AppColors.black),
                        TextBody12(
                          'قيد المراجعة',
                          color: HexColor('#377AD2'),
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
