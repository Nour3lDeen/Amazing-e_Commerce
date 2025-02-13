import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/cubits/products/products_cubit.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class CartCounterComponent extends StatelessWidget {
  const CartCounterComponent(
      {super.key,
        required this.productId,
        required this.cart,
        required this.productCount});

  final int productId;
  final bool cart;
  final int productCount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final CartCubit cartCubit = CartCubit.get(context);
        if (cart) {
          //cartCubit.productCounts.update(productId, (currentCount) => productCount);
        }
        return Row(
          children: [
            GestureDetector(
              onTapDown: (_) {if (cart) {
                 cartCubit.startIncrementing(productId);
              }
            //  cubit.startIncrementing(productId);
              },
              onTapUp: (_) {
               // cubit.stopIncrementing();
                cartCubit.stopIncrementing();
              },
              onTapCancel: () {
                //cubit.stopIncrementing();
                cartCubit.stopIncrementing();
              },
              onTap: () {
              //  cubit.incrementNumber(productId);
                cartCubit.incrementNumber(productId);
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
                  //'${cubit.getProductCount(productId)}',
                  ''
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
              //  cubit.decrementNumber(productId);
              },
              onTapDown: (_) {
              //  cubit.startDecrementing(productId);
              },
              onTapUp: (_) {
               // cubit.stopDecrementing();
              },
              onTapCancel: () {
               // cubit.stopDecrementing();
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
    );
  }
}