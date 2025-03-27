import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/cart_item_model/history_cart_model.dart';
import 'package:ecommerce/model/returned/returned_model.dart';
import 'package:ecommerce/view/screens/brands_sceen/brands_screen.dart';
import 'package:ecommerce/view/screens/categories/components/favorite_component/favorite_component.dart';
import 'package:ecommerce/view/screens/categories/components/share_component/share_component.dart';
import 'package:ecommerce/view/screens/others/policies/refund_policy/refund_policy.dart';
import 'package:ecommerce/view/screens/others/refund_requests/refund_request_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
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

import '../../../../view_model/cubits/home/bottom_nav_cubit.dart';
import '../../../common_components/custom_button/custom_button.dart';
import '../../categories/components/counter_component/counter_component.dart';
import '../../home/home_screen.dart';

class RefundDetailsScreen extends StatelessWidget {
  const RefundDetailsScreen(
      {super.key,
      required this.fromCart,
      required this.orderItem,
      required this.returnedItem});

  final bool fromCart;
  final OrderItems orderItem;
  final ReturnedModel returnedItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
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
                                fromCart
                                    ? orderItem.colorImage ?? ''
                                    : returnedItem.orderItem?.colorImage ?? '',
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
                                        productId: fromCart
                                            ? orderItem.product?.id ?? 0
                                            : returnedItem
                                                    .orderItem?.product?.id ??
                                                0),
                                    SizedBox(width: 10.w),
                                    const ShareComponent(),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        );
                      },
                    ),
                    SizedBox(
                      height: 410.h,
                    )
                  ],
                ),
                PositionedDirectional(
                  top: 260.h,
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
                              'طلب استرجاع للمنتج',
                              color: HexColor('#FD6868'),
                              fontSize: 20.sp,
                            )),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                TextTitle(
                                  fromCart
                                      ? '${orderItem.product?.name}'
                                      : '${returnedItem.orderItem?.product?.name}',
                                  color: AppColors.primaryColor,
                                  fontSize: 17.sp,
                                ),
                                const Spacer(),
                                TextDescription(
                                  fromCart
                                      ? '(${orderItem.product?.rate})'
                                      : '(${returnedItem.orderItem?.product?.rate})',
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
                                      fromCart
                                          ? '${orderItem.total} ر.س'
                                          : '${returnedItem.orderItem?.total} ر.س',
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
                                      fromCart
                                          ? '${orderItem.sizeCode}'
                                          : '${returnedItem.orderItem?.sizeCode}',
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
                                  color: HexColor(fromCart
                                      ? '${orderItem.colorCode ?? '#FFFFFF'}'
                                      : '${returnedItem.orderItem?.colorCode ?? '#FFFFFF'}'),
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              spacing: 6.w,
                              children: [
                                TextBody14(
                                  'العدد المطلوب : ',
                                  color: AppColors.black,
                                ),
                                TextBody14(
                                  fromCart
                                      ? '${orderItem.quantity} قطع'
                                      : '${returnedItem.orderItem?.quantity} قطع',
                                  color: AppColors.black,
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    const TextBody12('القطع المسترجعة'),
                                    SizedBox(height: 2.h),
                                    BlocBuilder<ProductsCubit, ProductsState>(
                                      builder: (context, state) {
                                        final ProductsCubit cubit =
                                            ProductsCubit.get(context);
                                        final int productId =
                                            orderItem.product?.id ?? 0;
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (fromCart) {
                                                  if (cubit.getProductCount(
                                                          productId) <
                                                      orderItem.quantity!) {
                                                    cubit.incrementNumber(
                                                        productId);
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height: 18.h,
                                                width: 18.w,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#B6B6B6'),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: TextBody12('+'),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 18.h,
                                              width: 32.w,
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Center(
                                                child: TextBody12(
                                                  fontSize: 11.sp,
                                                  fromCart
                                                      ? '${cubit.getProductCount(productId)}'
                                                      : '${returnedItem.orderItem?.quantity}',
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (fromCart) {
                                                  if (cubit.getProductCount(
                                                          productId) >
                                                      orderItem.quantity!) {
                                                    cubit.decrementNumber(
                                                        productId);
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height: 18.h,
                                                width: 18.w,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#B6B6B6'),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: TextBody14('-'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                )
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
                                    fromCart
                                        ? '${orderItem.product?.brandName ?? ''}'
                                        : '${returnedItem.orderItem?.product?.brandName ?? ''}',
                                    color: HexColor('#0082C8'),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                TextBody14(
                                  'تاريخ الطلب: ',
                                  fontSize: 10.sp,
                                ),
                                TextBody14(
                                    fromCart
                                        ? '${orderItem.createdAt}'
                                        : '${returnedItem.createdAt}',
                                    fontSize: 10.sp),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Visibility(
                              visible: fromCart,
                              replacement: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 60.h,
                                      width: 250.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(14.r),
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
                                            CartCubit.get(context)
                                                .localizeStatus(
                                                    returnedItem.status ?? ''),
                                            color: CartCubit.get(context)
                                                .statusColor(
                                                    returnedItem.status ?? ''),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  /* SizedBox(height: 12.h),
                                  TextTitle(
                                    'تفاصيل حالة الطلب',
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  const TextBody14(
                                      textAlign: TextAlign.center,
                                      'طلبكم قيد المراجعه من قبل القائمين في قسم استرجاع المنتجات لدينا , عادتاً ما يتم الرد خلال 48 ساعة فترقبو الرد من خلال الاشعارات الواردة اليكم علي التطبيق او عن طريق البريد الالكتروني الخاص بكم .')
                                */
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      TextTitle(
                                        'سبب الاسترجاع؟',
                                        color: AppColors.primaryColor,
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigation.push(
                                              context, const RefundPolicy());
                                        },
                                        child: Container(
                                            width: 140.w,
                                            height: 40.h,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                                color: HexColor('#63C2B1'),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                border: Border.all(
                                                    color:
                                                        AppColors.primaryColor),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(
                                                            alpha: 0.15),
                                                    offset: Offset(1.w, 3.h),
                                                    blurRadius: 6.0,
                                                  ),
                                                ]),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextBody12(
                                                  'سياسة الاسترجاع!',
                                                  color: AppColors.white,
                                                ),
                                                SizedBox(width: 8.w),
                                                SvgPicture.asset(
                                                    AppAssets.lightBulb)
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  DropdownButtonFormField<String>(
                                    items: CartCubit.get(context)
                                        .reasons
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item.name,
                                            child: TextBody12(
                                              '${item.name}',
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      CartCubit.get(context)
                                          .changeReason(value!);
                                      debugPrint('value: $value');
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor),
                                      ),
                                      fillColor: AppColors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                          right: 16.w, left: 16.w, bottom: 5.h),
                                      hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.black,
                                        fontFamily: 'Lamar',
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                    dropdownColor: AppColors.white,
                                    hint: TextBody12(
                                      'اختر سبب الاسترجاع',
                                      color: AppColors.black,
                                    ),
                                    iconSize: 0,
                                    icon: SvgPicture.asset(
                                      AppAssets.arrowDown,
                                      height: 10.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Center(
                                    child: TextTitle(
                                      'طريقة إرجاع النقود؟',
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  BlocBuilder<ProductsCubit, ProductsState>(
                                    builder: (context, state) {
                                      final cubit = ProductsCubit.get(context);
                                      return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                cubit
                                                    .changeRefundType('wallet');
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 24.w,
                                                    height: 24.h,
                                                    padding:
                                                        EdgeInsets.all(3.sp),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 1.5.sp),
                                                      color: Colors.transparent,
                                                    ),
                                                    child: Container(
                                                      width: 12.w,
                                                      height: 12.h,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          gradient: cubit
                                                                      .refundType ==
                                                                  'wallet'
                                                              ? LinearGradient(
                                                                  begin: Alignment
                                                                      .topRight,
                                                                  end: Alignment
                                                                      .bottomLeft,
                                                                  colors: [
                                                                      HexColor(
                                                                          '#29F3D1'),
                                                                      HexColor(
                                                                          '#177565'),
                                                                    ])
                                                              : null,
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              width: 1.sp),
                                                          color: cubit.refundType ==
                                                                  'wallet'
                                                              ? null
                                                              : Colors
                                                                  .transparent),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 6.w,
                                                  ),
                                                  const TextBody12(
                                                      'رصيد للمحفظة'),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cubit.changeRefundType('cash');
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 24.w,
                                                    height: 24.h,
                                                    padding:
                                                        EdgeInsets.all(3.sp),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor),
                                                      color: Colors.transparent,
                                                    ),
                                                    child: Container(
                                                      width: 12.w,
                                                      height: 12.h,
                                                      decoration: BoxDecoration(
                                                          color: cubit.refundType ==
                                                                  'cash'
                                                              ? null
                                                              : Colors
                                                                  .transparent,
                                                          shape: BoxShape
                                                              .circle,
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .primaryColor),
                                                          gradient: cubit
                                                                      .refundType ==
                                                                  'cash'
                                                              ? LinearGradient(
                                                                  begin: Alignment
                                                                      .topRight,
                                                                  end: Alignment
                                                                      .bottomLeft,
                                                                  colors: [
                                                                      HexColor(
                                                                          '#29F3D1'),
                                                                      HexColor(
                                                                          '#177565'),
                                                                    ])
                                                              : null),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 6.w,
                                                  ),
                                                  const TextBody12('نقدي'),
                                                ],
                                              ),
                                            ),
                                          ]);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Visibility(
                                visible: fromCart,
                                replacement: InkWell(
                                  borderRadius: BorderRadius.circular(14.r),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: AppColors.white
                                              .withValues(alpha: 0.65),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 6.0,
                                              sigmaY: 6.0,
                                            ),
                                            child: Container(
                                              width: 230.w,
                                              height: 180.h,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 24.h,
                                                  horizontal: 20.w),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.white,
                                                  width: 2.w,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.error_outline_rounded,
                                                    color: AppColors
                                                        .secondaryColor,
                                                    size: 60.sp,
                                                  ),
                                                  TextBody14(
                                                    'سيتم إلغاء طلب استرجاع \nالمنتج هل انت متأكد؟',
                                                    color: AppColors.black,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  BlocConsumer<CartCubit,
                                                      CartState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is CancelReturnedSuccessState) {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        AuthCubit.get(context)
                                                            .viewToast(
                                                                state.msg,
                                                                context,
                                                                Colors.green,
                                                                3);
                                                      }
                                                      if (state
                                                          is CancelReturnedErrorState) {
                                                        Navigator.pop(context);
                                                        AuthCubit.get(context)
                                                            .viewToast(
                                                                state.error,
                                                                context,
                                                                Colors.red,
                                                                4);
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      final cartCubit =
                                                          CartCubit.get(
                                                              context);
                                                      if (state
                                                          is CancelReturnedLoadingState) {
                                                        return Center(
                                                          child: LoadingAnimationWidget
                                                              .inkDrop(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  size: 15.sp),
                                                        );
                                                      }
                                                      return Row(
                                                        spacing: 8.w,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Expanded(
                                                            child: CustomButton(
                                                              onPressed: () {
                                                                cartCubit.cancelReturned(
                                                                    returnedItem
                                                                            .id ??
                                                                        0);
                                                                /*  Navigator.pop(
                                                              context,
                                                            );
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                            AuthCubit.get(
                                                                    context)
                                                                .viewToast(
                                                                    'تم إلغاء طلب الإسترجاع بنجاح',
                                                                    context,
                                                                    Colors
                                                                        .green,
                                                                    2);*/
                                                              },
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors: [
                                                                    HexColor(
                                                                      '#66B873',
                                                                    ),
                                                                    HexColor(
                                                                      '#0AB023',
                                                                    )
                                                                  ]),
                                                              borderRadius: 8.r,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            4.h),
                                                                child: SizedBox(
                                                                  width: 95.w,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      TextBody12(
                                                                        'تأكيد',
                                                                        color: AppColors
                                                                            .white,
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              4.w),
                                                                      SvgPicture
                                                                          .asset(
                                                                        AppAssets
                                                                            .right,
                                                                        colorFilter: ColorFilter.mode(
                                                                            AppColors.white,
                                                                            BlendMode.srcIn),
                                                                        height:
                                                                            14.h,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: CustomButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              backgroundColor:
                                                                  AppColors
                                                                      .white,
                                                              child: Container(
                                                                width: 95.w,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            4.h),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(8
                                                                            .r),
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .red)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    TextBody12(
                                                                      'إلغاء',
                                                                      color: AppColors
                                                                          .red,
                                                                    ),
                                                                    SizedBox(
                                                                        width: 4
                                                                            .w),
                                                                    Icon(
                                                                      Icons
                                                                          .cancel_outlined,
                                                                      color: AppColors
                                                                          .red,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        border: Border.all(
                                          color: AppColors.red,
                                          width: 1.5,
                                        ),
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.black
                                                .withValues(alpha: 0.15),
                                            offset: Offset(2.w, 3.h),
                                            blurRadius: 6.0,
                                          )
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextTitle(
                                          'إلغاء طلب الاسترجاع',
                                          color: AppColors.red,
                                        ),
                                        SizedBox(width: 6.w),
                                        SvgPicture.asset(
                                          AppAssets.cancel,
                                          height: 22.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                child: BlocConsumer<CartCubit, CartState>(
                                  listener: (context, state) {
                                    if (state
                                        is SendRefundRequestSuccessState) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return Dialog(
                                            backgroundColor: AppColors.white
                                                .withValues(alpha: 0.65),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 6.0,
                                                sigmaY: 6.0,
                                              ),
                                              child: Container(
                                                width: 230.w,
                                                height: 150.h,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                    horizontal: 20.w),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColors.white,
                                                    width: 2.w,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppAssets.confirm,
                                                      height: 75.h,
                                                    ),
                                                    TextTitle(
                                                      'تم تأكيد الطلب',
                                                      color: AppColors.black,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                            CartCubit.get(context)
                                                .getReturnedItems();
                                            Navigation.pushAndRemove(
                                                context, const HomeScreen());
                                            BottomNavCubit.get(context)
                                                .changeIndex(4);
                                            Navigation.push(context,
                                                const RefundRequestScreen());
                                      });
                                    }
                                    if (state is SendRefundRequestErrorState) {
                                      AuthCubit.get(context).viewToast(
                                          state.error,
                                          context,
                                          AppColors.red,
                                          4);
                                    }
                                  },
                                  builder: (context, state) {
                                    final cartCubit = CartCubit.get(context);
                                    if (state
                                        is SendRefundRequestLoadingState) {
                                      return Center(
                                          child: LoadingAnimationWidget.inkDrop(
                                              color: AppColors.primaryColor,
                                              size: 20.sp));
                                    } else {
                                      return InkWell(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        onTap: () {
                                          if (cartCubit.selectedReasonId!=-1){
                                            debugPrint('Accept Request');
                                            cartCubit.sendRefundRequest(
                                              orderId: orderItem.id ?? 0,
                                              quantity:
                                                  ProductsCubit.get(context)
                                                      .getProductCount(orderItem
                                                              .product?.id ??
                                                          0),
                                              type: 'normal',
                                              refundType:
                                                  ProductsCubit.get(context)
                                                      .refundType,
                                            );
                                          }else{
                                            AuthCubit.get(context).viewToast(
                                                'يرجى اختيار سبب',
                                                context,
                                                AppColors.red,
                                                3);
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 40.h,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 12.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 5.h),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  HexColor('#39FAD9'),
                                                  HexColor('#03A186')
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(14.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.black
                                                      .withValues(alpha: 0.15),
                                                  offset: Offset(0.0, 3.h),
                                                  blurRadius: 6.0,
                                                ),
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            spacing: 6.w,
                                            children: [
                                              TextTitle(
                                                'تأكيد الطلب',
                                                color: AppColors.white,
                                              ),
                                              SvgPicture.asset(
                                                AppAssets.right,
                                                height: 18.h,
                                                colorFilter: ColorFilter.mode(
                                                    AppColors.white,
                                                    BlendMode.srcIn),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
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
