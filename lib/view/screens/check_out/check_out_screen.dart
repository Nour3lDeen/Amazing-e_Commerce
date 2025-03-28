import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/cart_item_model/cart_item_model.dart';
import 'package:ecommerce/view/common_components/custom_app_bar/custom_app_bar.dart';
import 'package:ecommerce/view/screens/check_out/confirm_check_out_dialog/confirm_check_out_dialog.dart';
import 'package:ecommerce/view/screens/home/home_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/brands/brand_cubit.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = CartCubit.get(context);
        final cartItem = cartCubit.cartItem;

        final num total = (cartItem!.total ?? 0) +
            (AuthCubit.get(context)
                    .user
                    ?.addresses
                    ?.firstWhere((e) => e.id == cartCubit.selectedAddress)
                    .cityShippingAmount ??
                0);
        final tax = BottomNavCubit.get(context).settings.taxPercentage! *
            (cartItem.total ?? 0) /
            100;
        final walletBalance =
            double.tryParse(AuthCubit.get(context).user!.wallet ?? '0') ?? 0.0;
        final double remainingBalance = walletBalance - (total + tax);
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(
                    right: 16.w, left: 16.w, bottom: 16.h, top: 90.h),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.back),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  controller: BrandCubit.get(context).scrollController,
                  clipBehavior: Clip.none,
                  child: Column(
                    children: [
                      Column(
                        spacing: 8.h,
                        children:
                            List.generate(cartItem.cartItems!.length, (index) {
                          final item = cartItem.cartItems![index];
                          return Container(
                            height: 105.h,
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                right: 4.w, left: 8.w, bottom: 4.h, top: 4.h),
                            decoration: BoxDecoration(
                              color: HexColor('#DCDCDC'),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
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
                                    color: AppColors.white,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(item
                                              .color?.images?.first.url ??
                                          'https://sharidah.sa/ecom/backend/public/storage/1121/961.jpeg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    spacing: 4.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextBody14(
                                              fontSize: 12.sp,
                                              item.product?.name ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextDescription(
                                              '(${item.product?.rate})'),
                                          SizedBox(
                                            height: 6.w,
                                          ),
                                          SvgPicture.asset(AppAssets.star)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible:
                                                item.size!.discountPrice! > 0,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: Align(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                child: Text(
                                                    '${item.size!.basicPrice} ر.س',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Lamar',
                                                      fontSize: 10.sp,
                                                      color: AppColors.red
                                                          .withValues(
                                                              alpha: 0.7),
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor: AppColors
                                                          .red
                                                          .withValues(
                                                              alpha: 0.8),
                                                      decorationThickness: 1.5,
                                                    )),
                                              ),
                                            ),
                                          ),
                                          TextBody12(
                                            '${item.size!.discountPrice! > 0 ? item.size!.discountPrice : item.size!.basicPrice} ر.س',
                                            color: AppColors.black,
                                          ),
                                          const Spacer(),
                                          Visibility(
                                            visible:
                                                item.size!.discountPrice! > 0,
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                    vertical: 1.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        HexColor('#FD6C6C'),
                                                        HexColor('#B84141'),
                                                      ],
                                                    )),
                                                child: TextBody12(
                                                  'خصم ${item.size!.discountRate}%',
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
                                                '${item.color!.colorCode}',
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.black
                                                      .withValues(alpha: 0.15),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 3.h),
                                                )
                                              ]),
                                        ),
                                        const Spacer(),
                                        TextBody12(
                                          'العدد المطلوب',
                                          fontSize: 10.sp,
                                        ),
                                      ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const TextBody12('المقاس'),
                                          SizedBox(width: 30.w),
                                          TextBody12('${item.size?.sizeCode}'),
                                          const Spacer(),
                                          TextBody12(
                                            '${item.quantity} قطع',
                                            fontSize: 10.sp,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          )
                                        ],
                                      ),
                                      //SizedBox(height: 4.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        height: 2.5.h,
                        width: double.infinity,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3.h),
                              blurRadius: 6.0,
                              color: AppColors.black.withValues(alpha: 0.15))
                        ]),
                        child: Divider(
                          color: AppColors.black,
                          thickness: 0.5,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          TextBody12(
                            'الإجمالي الفرعي',
                            color: AppColors.black.withValues(alpha: 0.8),
                          ),
                          const Spacer(),
                          TextBody12(
                            '${cartItem.total} ر.س.',
                            color: AppColors.black.withValues(alpha: 0.8),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          TextBody12(
                            'التوصيل',
                            color: AppColors.black.withValues(alpha: 0.8),
                          ),
                          const Spacer(),
                          TextBody12(
                            '${AuthCubit.get(context).user?.addresses?.firstWhere((e) => e.id == cartCubit.selectedAddress).cityShippingAmount}  ر.س',
                            color: AppColors.black.withValues(alpha: 0.8),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          TextBody12(
                            'الضريبة',
                            color: AppColors.black.withValues(alpha: 0.8),
                          ),
                          const Spacer(),
                          TextBody12(
                            '$tax ر.س.',
                            color: AppColors.black.withValues(alpha: 0.8),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Divider(
                          color: AppColors.black.withValues(alpha: 0.8),
                          thickness: 0.5,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Visibility(
                        visible: cartCubit.selectedPaymentMethod != 'cod',
                        replacement: Row(
                          spacing: 6.w,
                          children: [
                            SvgPicture.asset(
                              AppAssets.cashCheck,
                              height: 22.h,
                            ),
                            TextBody14(
                              'كاش عند الإستلام',
                              color: AppColors.black.withValues(alpha: 0.8),
                            ),
                            const Spacer(),
                            TextBody14(
                              '${AuthCubit.get(context).user?.addresses?.firstWhere((e) => e.id == cartCubit.selectedAddress).name}',
                              color: AppColors.black.withValues(alpha: 0.8),
                            ),
                            SvgPicture.asset(AppAssets.location2)
                          ],
                        ),
                        child: Row(
                          spacing: 6.w,
                          children: [
                            SvgPicture.asset(
                              AppAssets.cashCheck,
                              height: 22.h,
                            ),
                            TextBody14(
                              'من رصيد المحفظة',
                              color: AppColors.black.withValues(alpha: 0.8),
                            ),
                            const Spacer(),
                            TextBody14(
                              '${AuthCubit.get(context).user?.addresses?.firstWhere((e) => e.id == cartCubit.selectedAddress).name}',
                              color: AppColors.black.withValues(alpha: 0.8),
                            ),
                            SvgPicture.asset(AppAssets.location2)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        height: 2.5.h,
                        width: double.infinity,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3.h),
                              blurRadius: 6.0,
                              color: AppColors.black.withValues(alpha: 0.15))
                        ]),
                        child: Divider(
                          color: AppColors.black,
                          thickness: 0.5,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Visibility(
                          visible: cartCubit.selectedPaymentMethod != 'cod',
                          child: Column(
                            children: [
                              Row(children: [
                                TextBody14(
                                  'رصيد المحفظة\n${AuthCubit.get(context).user?.wallet} ر.س',
                                  fontSize: 12.sp,
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                TextBody14(
                                  'الرصيد المتبقي\n${remainingBalance < 0 ? 0 : remainingBalance} ر.س',
                                  fontSize: 12.sp,
                                  textAlign: TextAlign.center,
                                )
                              ]),
                              SizedBox(height: 8.h),
                            ],
                          )),
                      Row(spacing: 8.w, children: [
                        TextBody14('كود الخصم',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black.withValues(alpha: 0.8)),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.black.withValues(alpha: 0.15),
                                  offset: Offset(1.w, 2.h),
                                  blurRadius: 6.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.black,
                                fontFamily: 'Lamar',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'ادخل كود الخصم';
                                }
                                return null;
                              },
                              controller: cartCubit.couponController,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              cursorColor: AppColors.primaryColor,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                suffixIcon: BlocConsumer<CartCubit, CartState>(
                                  listener: (context, state) {
                                    if (state is CheckCouponSuccessState) {
                                      cartCubit.getCartItems();
                                      AuthCubit.get(context).viewToast(
                                          'تم تطبيق قصيمة الخصم بنجاح',
                                          context,
                                          Colors.green,
                                          3);
                                    }
                                    if (state is CheckCouponErrorState) {
                                      AuthCubit.get(context).viewToast(
                                          state.error, context, Colors.red, 3);
                                    }
                                    if (state is RemoveCouponSuccessState) {
                                      AuthCubit.get(context).viewToast(
                                          state.msg, context, Colors.green, 3);
                                    }
                                    if (state is RemoveCouponErrorState) {
                                      AuthCubit.get(context).viewToast(
                                          state.error, context, Colors.red, 3);
                                    }
                                  },
                                  builder: (context, state) {
                                    return Skeletonizer(
                                      enabled:
                                          state is CheckCouponLoadingState ||
                                              state is RemoveCouponLoadingState,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (cartItem.coupon != null) {
                                              cartCubit.removeCoupon();
                                            } else if (cartCubit
                                                    .couponController
                                                    .text
                                                    .isNotEmpty &&
                                                cartCubit.activeCoupon) {
                                              cartCubit.checkCoupon();
                                            }
                                          },
                                          child: Row(
                                            spacing: 2.w,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextBody14(
                                                cartCubit.activeCoupon
                                                    ? 'تطبيق'
                                                    : 'إلغاء',
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black
                                                        .withValues(
                                                            alpha: 0.15),
                                                    offset: Offset(0, 2.h),
                                                    blurRadius: 6.0,
                                                  ),
                                                ],
                                                color: cartCubit.activeCoupon
                                                    ? AppColors.primaryColor
                                                    : AppColors.red,
                                              ),
                                              SvgPicture.asset(
                                                cartCubit.activeCoupon
                                                    ? AppAssets.doubleConfirm
                                                    : AppAssets.cancel,
                                                height: 18.h,
                                                colorFilter: ColorFilter.mode(
                                                    cartCubit.activeCoupon
                                                        ? AppColors.primaryColor
                                                        : AppColors.red,
                                                    BlendMode.srcIn),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                hintText: 'أدخل كود الخصم',
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.grey,
                                  fontFamily: 'Lamar',
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 4.h),
                                fillColor: AppColors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide.none),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide.none),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Container(
                            height: 70.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(color: AppColors.primaryColor),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#5BFFE3')
                                      .withValues(alpha: 0.35),
                                  blurRadius: 6,
                                  offset: Offset(1.w, 3.h),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextBody14(
                                  'إجمالي المبلغ المستحق عند الإستلام',
                                  color: AppColors.primaryColor,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Visibility(
                                    visible: false,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        child: Text('132.5 ر.س',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Lamar',
                                              fontSize: 10.sp,
                                              color: AppColors.red
                                                  .withValues(alpha: 0.7),
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: AppColors.red
                                                  .withValues(alpha: 0.8),
                                              decorationThickness: 1.5,
                                            )),
                                      ),
                                    ),
                                  ),
                                  TextBody12(
                                    '${total + tax} ر.س',
                                    color: AppColors.black,
                                  ),
                                ]),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      BlocConsumer<CartCubit, CartState>(
                        listener: (context, state) {
                          if (state is CheckoutSuccessState) {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const ConfirmCheckOutDialog());
                            cartCubit.showHistory();
                            cartCubit.cartItems.clear;
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigation.pushAndRemove(
                                  context, const HomeScreen());

                              BottomNavCubit.get(context).changeIndex(3);
                              cartCubit.changeIsSelected(false, true);
                            });
                          } else if (state is CheckoutErrorState) {
                            AuthCubit.get(context).viewToast(
                                state.error, context, AppColors.red, 4);
                          }
                        },
                        builder: (context, state) {
                          if (state is CheckoutLoadingState) {
                            return LoadingAnimationWidget.inkDrop(
                                color: AppColors.primaryColor, size: 15.sp);
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14.r),
                                onTap: () {
                                  cartCubit.checkout();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      HexColor('#31D3C6'),
                                      HexColor('#208B78'),
                                    ]),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black
                                            .withValues(alpha: 0.15),
                                        blurRadius: 6,
                                        offset: Offset(1.w, 3.h),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 6.w,
                                    children: [
                                      TextBody14(
                                        'تأكيد الطلب',
                                        color: AppColors.white,
                                      ),
                                      SvgPicture.asset(AppAssets.doubleConfirm)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 50.h,
                      )
                    ],
                  ),
                ),
              ),
              const CustomAppBar(
                  title: 'مراجعة الطلب',
                  isOffers: false,
                  hasSeasonsDropDown: false),
              PositionedDirectional(
                top: 48.h,
                start: 0.w,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ]),
                      child: SvgPicture.asset(
                        AppAssets.backIcon,
                        height: 28.h,
                        width: 28.w,
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
