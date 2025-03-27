import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/cart_item_model/history_cart_model.dart';
import 'package:ecommerce/view/screens/brands_sceen/brands_screen.dart';
import 'package:ecommerce/view/screens/cart/components/rate_component/rate_component.dart';
import 'package:ecommerce/view/screens/categories/components/favorite_component/favorite_component.dart';
import 'package:ecommerce/view/screens/categories/components/share_component/share_component.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../model/sections_model/sections_model.dart';
import '../../../../view_model/cubits/cart/cart_cubit.dart';
import '../../../common_components/custom_button/custom_button.dart';
import '../../categories/product_details/product_details_screen.dart';
import '../components/refund_component/refund_component.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen(
      {super.key, required this.fromCart, required this.orderItem});

  final OrderItems orderItem;
  final bool fromCart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  children: [
                    BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height / 2,
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 38.h, bottom: 70.h),
                          decoration: BoxDecoration(
                            color: AppColors.grey.withValues(alpha: 0.2),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                orderItem.colorImage ?? '',
                              ),
                            ),
                          ),
                          child: Stack(children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            color: AppColors.black
                                                .withValues(alpha: 0.15),
                                            blurRadius: 10,
                                            offset: const Offset(0, 1),
                                          ),
                                        ], shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                          AppAssets.backIcon1,
                                          height: 24.h,
                                          width: 24.w,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    FavoriteComponent(
                                        productId: orderItem.product?.id ?? 0),
                                    SizedBox(width: 10.w),
                                    const ShareComponent(),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ]),
                        );
                      },
                    ),
                    SizedBox(
                      height: orderItem.status == 'pending'
                          ? 420.h
                          : orderItem.status == 'completed'
                              ? 450.h
                              : 400.h,
                    )
                  ],
                ),
                PositionedDirectional(
                  top: 285.h,
                  bottom: 0,
                  start: 0,
                  end: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.r),
                            topRight: Radius.circular(32.r),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: Image.asset(
                              AppAssets.customBack,
                              height: double.infinity,
                              width: double.infinity,
                            ).image,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: TextTitle(
                              'تفاصيل الطلب',
                              color: AppColors.primaryColor,
                              fontSize: 20.sp,
                            )),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      debugPrint(
                                          'Product ID: ${orderItem.product?.id}');
                                      cubit.showProduct(
                                          orderItem.product?.id ?? 0);
                                      if (orderItem.product?.sizes != null) {
                                        cubit.sizes =
                                            orderItem.product?.sizes ?? [];
                                        cubit.initializeSelectedSize();
                                      }
                                      cubit.initializeSelectedSize();
                                      cubit.sizes = [];
                                      cubit.pushToStack(orderItem
                                              .product
                                              ?.colors
                                              ?.first
                                              .images
                                              ?.first
                                              .url ??
                                          '');
                                      Navigation.push(
                                        context,
                                        ProductDetailsScreen(
                                          product:
                                              orderItem.product ?? Products(),
                                          productId: orderItem.product?.id ?? 0,
                                          title: orderItem.product?.name ?? '',
                                        ),
                                      );
                                    },
                                    child: TextTitle(
                                      orderItem.product?.name ?? '',
                                      color: AppColors.primaryColor,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                TextDescription(
                                  '(${orderItem.product?.rate ?? ''})',
                                ),
                                SvgPicture.asset(AppAssets.star)
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    TextBody14(
                                      '${orderItem.total ?? ''} ر.س',
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const TextBody14('المقاس'),
                                SizedBox(width: 8.w),
                                Container(
                                    width: 65.w,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: TextBody12(
                                      orderItem.sizeCode ?? '',
                                    ))
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Center(
                              child: Container(
                                width: 40.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: HexColor('${orderItem.colorCode}'),
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.15),
                                        offset: Offset(2.w, 5.h),
                                        blurRadius: 6.0,
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              spacing: 6.w,
                              children: [
                                TextBody14(
                                  'العدد المطلوب :  ${orderItem.quantity ?? ''} قطع ',
                                  color: AppColors.black,
                                ),
                                const Spacer(),
                                TextBody12('تاريخ الطلب: ', fontSize: 10.sp),
                                TextBody12('${orderItem.createdAt ?? ''}',
                                    fontSize: 10.sp),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 6.w,
                              children: [
                                const TextBody14('العلامة التجارية:'),
                                GestureDetector(
                                  onTap: () {
                                    Navigation.push(
                                        context, const BrandsScreen());
                                  },
                                  child: TextBody14(
                                    '${orderItem.product?.brandName ?? ''}',
                                    color: HexColor('#0082C8'),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextBody14(
                              'وصف المنتج',
                              color: AppColors.primaryColor,
                              fontSize: 16.sp,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final text = BottomNavCubit.get(context)
                                      .refactorText(
                                          orderItem.product?.description ?? '');
                                  final textPainter = TextPainter(
                                    text: TextSpan(
                                      text: text,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Lamar',
                                      ),
                                    ),
                                    maxLines: 5,
                                    textDirection: TextDirection.rtl,
                                  );
                                  textPainter.layout(
                                      maxWidth: constraints.maxWidth);
                                  if (textPainter.didExceedMaxLines) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (cubit.everyProducts
                                            .contains(orderItem.product)) {
                                          debugPrint(
                                              'Product ID: ${orderItem.product?.id}');
                                          cubit.showProduct(
                                              orderItem.product?.id ?? 0);
                                          if (orderItem.product?.sizes !=
                                              null) {
                                            cubit.sizes =
                                                orderItem.product?.sizes ?? [];
                                            cubit.initializeSelectedSize();
                                          }
                                          cubit.initializeSelectedSize();
                                          cubit.sizes = [];
                                          cubit.pushToStack(orderItem
                                                  .product
                                                  ?.colors
                                                  ?.first
                                                  .images
                                                  ?.first
                                                  .url ??
                                              '');
                                          Navigation.push(
                                            context,
                                            ProductDetailsScreen(
                                              product: orderItem.product ??
                                                  Products(),
                                              productId:
                                                  orderItem.product?.id ?? 0,
                                              title:
                                                  orderItem.product?.name ?? '',
                                            ),
                                          );
                                        } else {
                                          cubit.viewToast(
                                              'هذا المنتج غير متوفر',
                                              context,
                                              AppColors.red);
                                        }
                                      },
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: text.substring(
                                                  0,
                                                  textPainter
                                                      .getPositionForOffset(
                                                          Offset(
                                                              constraints
                                                                  .maxWidth,
                                                              5 * 30.sp))
                                                      .offset),
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14.sp,
                                                fontFamily: 'Lamar',
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' ... عرض المزيد',
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                // Customize color
                                                fontSize: 14.sp,
                                                fontFamily: 'Lamar',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        maxLines: 5,
                                        overflow: TextOverflow.clip,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      text,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Lamar',
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Center(
                              child: Container(
                                height: 60.h,
                                width: 250.w,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(14.r),
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.4),
                                        offset: Offset(2.w, 3.h),
                                        blurRadius: 6.0,
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextTitle(
                                      'حالة الطلب',
                                      color: AppColors.primaryColor,
                                    ),
                                    TextBody14(
                                      CartCubit.get(context).localizeStatus(
                                          orderItem.status ?? ''),
                                      color: CartCubit.get(context)
                                          .statusColor(orderItem.status ?? ''),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Visibility(
                                visible: orderItem.status == 'completed',
                                replacement: orderItem.status == 'pending'
                                    ? InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                    backgroundColor: AppColors
                                                        .white
                                                        .withValues(
                                                            alpha: 0.65),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                    ),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                        sigmaX: 4.0,
                                                        sigmaY: 4.0,
                                                      ),
                                                      child: Container(
                                                        width: 250.w,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12.h,
                                                                horizontal:
                                                                    12.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color:
                                                                AppColors.white,
                                                            width: 2.w,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          spacing: 6.h,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .error_outline_rounded,
                                                              color:
                                                                  AppColors.red,
                                                              size: 50.sp,
                                                            ),
                                                            const TextBody14(
                                                              'سيتم إلغاء طلب المنتج \nهل انت متأكد؟',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            BlocConsumer<
                                                                CartCubit,
                                                                CartState>(
                                                              listener:
                                                                  (context,
                                                                      state) {
                                                                if (state
                                                                    is CancelOrderSuccessState) {
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pop(
                                                                      context);
                                                                  AuthCubit.get(
                                                                          context)
                                                                      .viewToast(
                                                                          state
                                                                              .msg,
                                                                          context,
                                                                          Colors
                                                                              .green,
                                                                          3);
                                                                }
                                                                if (state
                                                                    is CancelOrderErrorState) {
                                                                  AuthCubit.get(
                                                                          context)
                                                                      .viewToast(
                                                                          state
                                                                              .error,
                                                                          context,
                                                                          AppColors
                                                                              .red,
                                                                          3);
                                                                }
                                                              },
                                                              builder: (context,
                                                                  state) {
                                                                final cartCubit =
                                                                    CartCubit.get(
                                                                        context);
                                                                if (state
                                                                    is CancelOrderLoadingState) {
                                                                  return LoadingAnimationWidget.inkDrop(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                      size: 15
                                                                          .sp);
                                                                } else {
                                                                  return Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      CustomButton(
                                                                        onPressed:
                                                                            () {
                                                                          cartCubit
                                                                              .cancelOrder(
                                                                            orderItem.orderId ??
                                                                                0,
                                                                          );
                                                                        },
                                                                        gradient:
                                                                            LinearGradient(colors: [
                                                                          HexColor(
                                                                            '#DA6A6A',
                                                                          ),
                                                                          HexColor(
                                                                            '#B20707',
                                                                          )
                                                                        ]),
                                                                        borderRadius:
                                                                            8.r,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(vertical: 4.h),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                95.w,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                TextBody12(
                                                                                  'إلغاء',
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
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        backgroundColor:
                                                                            AppColors.white,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              95.w,
                                                                          padding:
                                                                              EdgeInsets.symmetric(vertical: 4.h),
                                                                          decoration: BoxDecoration(
                                                                              color: AppColors.white,
                                                                              borderRadius: BorderRadius.circular(8.r),
                                                                              border: Border.all(color: AppColors.red)),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              TextBody12(
                                                                                'رجوع',
                                                                                color: AppColors.red,
                                                                              ),
                                                                              SizedBox(width: 4.w),
                                                                              SvgPicture.asset(
                                                                                AppAssets.backIcon3,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Container(
                                          width: double.infinity,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    HexColor('#CA4F4F'),
                                                    HexColor('#FF9090'),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.15),
                                                  offset: Offset(1.w, 3.h),
                                                  blurRadius: 6.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextBody14(
                                                'إلغاء طلب المنتج',
                                                color: AppColors.white,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              SvgPicture.asset(
                                                AppAssets.cancel,
                                                colorFilter: ColorFilter.mode(
                                                    AppColors.white,
                                                    BlendMode.srcIn),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                child: Column(
                                  spacing: 8.h,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => RateComponent(
                                                  productId:
                                                      orderItem.product?.id ??
                                                          0,
                                                ));
                                      },
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Container(
                                        width: double.infinity,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor('#2BC339'),
                                              HexColor('#049312'),
                                            ]),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withValues(alpha: 0.15),
                                                offset: Offset(1.w, 3.h),
                                                blurRadius: 6.0,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextBody14(
                                              'تقييم المنتج',
                                              color: AppColors.white,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            SvgPicture.asset(AppAssets.rate)
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                RefundComponent(
                                                  orderItem: orderItem,
                                                ));
                                      },
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: Container(
                                        width: double.infinity,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor('#39FAD9'),
                                              HexColor('#03A186'),
                                            ]),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withValues(alpha: 0.15),
                                                offset: Offset(1.w, 3.h),
                                                blurRadius: 6.0,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(14.r)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextBody14(
                                              'استرجاع المنتج',
                                              color: AppColors.white,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            SvgPicture.asset(
                                              AppAssets.cloud,
                                              height: 16.h,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(height: 60.h)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
