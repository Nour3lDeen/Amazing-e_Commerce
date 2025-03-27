import 'package:ecommerce/model/returned/returned_model.dart';
import 'package:ecommerce/view/common_components/custom_app_bar/custom_app_bar.dart';
import 'package:ecommerce/view/screens/others/refund_requests/components/refund_card.dart';
import 'package:ecommerce/view_model/cubits/brands/brand_cubit.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class RefundRequestScreen extends StatelessWidget {
  const RefundRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.back),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cartCubit = CartCubit.get(context);
                if (state is GetReturnedItemsLoadingState) {
                  return Skeletonizer(
                    child: ListView.separated(
                        controller: BrandCubit.get(context).scrollController,
                        padding: EdgeInsets.only(top: 95.h, bottom: 32.h),
                        itemBuilder: (context, index) => RefundCard(
                              returnedItem: ReturnedModel(),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8.h,
                            ),
                        itemCount: 4),
                  );
                } else {
                  return Visibility(
                    visible: cartCubit.returnedItems.isEmpty,
                    replacement: ListView.separated(
                        controller: BrandCubit.get(context).scrollController,
                        padding: EdgeInsets.only(top: 95.h, bottom: 32.h),
                        itemBuilder: (context, index) => RefundCard(
                              returnedItem: cartCubit.returnedItems[index],
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8.h,
                            ),
                        itemCount: cartCubit.returnedItems.length),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.refundRequest),
                          TextBody14(
                            'لم يتم استرجاع منتجات لديك',
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ]),
                  );
                }
              },
            ),
          ),
          const CustomAppBar(
              title: 'طلبات الاسترجاع',
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
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
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
  }
}
