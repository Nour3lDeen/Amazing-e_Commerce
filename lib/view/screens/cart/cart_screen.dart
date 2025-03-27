import 'package:ecommerce/model/cart_item_model/cart_item_model.dart'
    as cart_item;
import 'package:ecommerce/model/cart_item_model/history_cart_model.dart';
import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view/screens/cart/components/cart_card/cart_card.dart';
import 'package:ecommerce/view/screens/cart/components/check_out_component/check_out_component.dart';
import 'package:ecommerce/view/screens/cart/components/history_card/history_card.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../model/cart_item_model/cart_item_model.dart';
import '../../../view_model/data/local/shared_helper.dart';
import '../../../view_model/data/local/shared_keys.dart';
import '../../../view_model/utils/app_assets/app_assets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        return Scaffold(
            body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: SharedHelper.getData(SharedKeys.platform) == 'ios'
                  ? 0.h
                  : 16.h),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(AppAssets.back).image,
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Center(
                  child: TextTitle(
                'عربة المنتجات',
                color: AppColors.primaryColor,
                fontSize: 20.sp,
              )),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  spacing: 16.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        borderRadius: 8.r,
                        gradient: !cubit.isSelected
                            ? LinearGradient(colors: [
                                HexColor('#31D3C6'),
                                HexColor('#208B78'),
                              ])
                            : null,
                        child: Container(
                          height: 32.h,
                          width: 130.w,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: !cubit.isSelected ? AppColors.white : null,
                            borderRadius: BorderRadius.circular(8.r),
                            border: !cubit.isSelected
                                ? Border.all(color: AppColors.primaryColor)
                                : null,
                          ),
                          child: Center(
                            child: TextBody14(
                              'المنتجات الحالية',
                              color: !cubit.isSelected
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (!cubit.isSelected) {
                            cubit.changeIsSelected(true, false);
                            if (SharedHelper.getData(SharedKeys.token) != null) {
                              cubit.getCartItems();
                            }
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        borderRadius: 8.r,
                        gradient: cubit.isSelected
                            ? LinearGradient(colors: [
                                HexColor('#31D3C6'),
                                HexColor('#208B78'),
                              ])
                            : null,
                        child: Container(
                          height: 32.h,
                          width: 130.w,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: cubit.isSelected ? AppColors.white : null,
                            borderRadius: BorderRadius.circular(8.r),
                            border: cubit.isSelected
                                ? Border.all(color: AppColors.primaryColor)
                                : null,
                          ),
                          child: Center(
                            child: TextBody14(
                              'مشترياتي السابقة',
                              color: cubit.isSelected
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (cubit.isSelected) {
                            cubit.changeIsSelected(false, true);
                            if (SharedHelper.getData(SharedKeys.token) != null) {
                              cubit.getReasons();
                              cubit.showHistory();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              state is! GetCartItemsLoadingState && cubit.cartItems.isNotEmpty
                  ? Visibility(
                      visible: !cubit.isHistory,
                      child: ListView.separated(
                          reverse: true,
                          separatorBuilder: (context, index) => SizedBox(
                                height: 8.h,
                              ),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: cubit.cartItems.length,
                          itemBuilder: (context, index) {
                            return CartCard(
                              cartItem: cubit.cartItem!.cartItems![index],
                              productId: cubit
                                  .cartItem!.cartItems![index].product!.id!,
                            );
                          }),
                    )
                  : state is! GetCartItemsLoadingState &&
                          cubit.cartItems.isEmpty &&
                          !cubit.isHistory
                      ? Column(children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Image.asset(AppAssets.cartEmpty),
                          SizedBox(
                            height: 16.h,
                          ),
                          TextTitle(
                            'لم يتم إضافة منتجات إلى \nالعربة',
                            textAlign: TextAlign.center,
                            color: AppColors.primaryColor,
                          )
                        ])
                      : state is GetCartItemsLoadingState
                          ? Skeletonizer(
                              child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return CartCard(
                                      cartItem: CartItems(),
                                      productId: index,
                                    );
                                  }),
                            )
                          : const SizedBox(),
              Visibility(
                visible: !cubit.isSelected,
                child: state is ShowHistoryLoadingState
                    ? Skeletonizer(
                        child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 8.h,
                                ),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return HistoryCard(
                                orderItem: OrderItems(),
                              );
                            }),
                      )
                    : state is! ShowHistoryLoadingState &&
                            cubit.orderItems.isEmpty
                        ? Column(children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            Image.asset(AppAssets.cartEmpty),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextTitle(
                              'لا يوجد مشتريات سابقة',
                              textAlign: TextAlign.center,
                              color: AppColors.primaryColor,
                            )
                          ])
                        : ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 8.h,
                                ),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: cubit.orderItems.length,
                            itemBuilder: (context, index) {
                              return HistoryCard(
                                orderItem: cubit.orderItems[index],
                              );
                            }),
              ),
              Visibility(
                visible: !cubit.isHistory,
                child: SizedBox(
                  height: 32.h,
                ),
              ),
              Visibility(
                visible: !cubit.isHistory &&
                    state is! GetCartItemsLoadingState &&
                    cubit.cartItems.isNotEmpty,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 30.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black
                                          .withValues(alpha: 0.3),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: Offset(-3.w, 0.h),
                                    )
                                  ]),
                              child: CustomButton(
                                borderRadius: 25.r,
                                gradient: LinearGradient(colors: [
                                  HexColor('#31D3C6'),
                                  HexColor('#208B78'),
                                ]),
                                onPressed: () {
                                  cubit.selectPaymentMethod('wallet');
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      useSafeArea: true,
                                      isScrollControlled: true,
                                      transitionAnimationController:
                                          AnimationController(
                                        vsync: Scaffold.of(context),
                                        duration:
                                            const Duration(milliseconds: 500),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        if (AuthCubit.get(context)
                                            .user!
                                            .addresses!
                                            .isNotEmpty) {
                                          cubit.selectAddress(
                                              AuthCubit.get(context)
                                                      .user
                                                      ?.addresses
                                                      ?.first
                                                      .id ??
                                                  0);
                                        }
                                        return const CheckOutComponent();
                                      });
                                  debugPrint('توجه للدفع');
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextBody14(
                                      'التوجه للدفع',
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    SvgPicture.asset(AppAssets.buy)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextTitle(
                                  'الإجمالي',
                                  color: AppColors.black,
                                  fontSize: 14.sp,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                TextBody12(
                                  '${cubit.cartItem?.total} ر.س',
                                  fontSize: 12.sp,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: SharedHelper.getData(SharedKeys.platform) == 'ios'
                    ? 50.h
                    : 60.h,
              )
            ],
          ),
        ));
      },
    );
  }
}
