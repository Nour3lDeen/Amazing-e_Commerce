import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../model/cart_item_model/cart_item_model.dart';
import '../../../../../view_model/cubits/products/products_cubit.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../../common_components/custom_button/custom_button.dart';

class CartCounterComponent extends StatelessWidget {
  const CartCounterComponent(
      {super.key,
      required this.productId,
      required this.productCount,
      required this.cartItem});

  final CartItems cartItem;
  final int productId;
  final int productCount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is UpdateCartItemSuccessState) {
          ProductsCubit.get(context)
              .viewToast(state.msg, context, Colors.green);
        } else if (state is UpdateCartItemErrorState) {
          ProductsCubit.get(context)
              .viewToast(state.error, context, Colors.red);
        }
      },
      builder: (context, state) {
        final cartCubit = CartCubit.get(context);
        if (state is UpdateCartItemLoadingState) {
          return Skeletonizer(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {

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
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: TextBody12(
                      fontSize: 11.sp,
                      '$productCount',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {

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
            ),
          );
        } else {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  cartCubit.updateCartItem(
                      productId: productId,
                      cartId: cartItem.id!,
                      quantity: productCount,
                      operation: 'increment',
                      sizeId: cartItem.size?.id ?? 0);
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
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: TextBody12(
                    fontSize: 11.sp,
                    '$productCount',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {if(productCount>1){
                  cartCubit.updateCartItem(
                      productId: productId,
                      cartId: cartItem.id!,
                      quantity: productCount,
                      operation: 'decrement',
                      sizeId: cartItem.size?.id ?? 0);
                }
                  else{
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
        }
      },
    );
  }
}
