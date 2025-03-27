import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/cubits/products/products_cubit.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class CounterComponent extends StatelessWidget {
  const CounterComponent(
      {super.key,
      required this.productId,
      required this.cart,
      required this.productCount});

  final int productId;
  final bool cart;
  final int productCount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final ProductsCubit cubit = ProductsCubit.get(context);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {

                cubit.incrementNumber(productId);
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
                  '${cubit.getProductCount(productId)}',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                cubit.decrementNumber(productId);
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
