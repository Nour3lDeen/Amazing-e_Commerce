import 'package:ecommerce/model/cart_item_model/history_cart_model.dart';
import 'package:ecommerce/model/start_design/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view/screens/cart/components/cart_counter_component/cart_counter_component.dart';
import 'package:ecommerce/view/screens/cart/order_details/order_details_screen.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../view_model/cubits/cart/cart_cubit.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../categories/product_details/product_details_screen.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.orderItem});

  final OrderItems orderItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ProductsCubit.get(context).pushToStack(orderItem.colorImage ?? '');
        Navigation.push(
            context,
            OrderDetailsScreen(
              fromCart: true,
              orderItem: orderItem,
            ));
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
                color: AppColors.white,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(orderItem.colorImage ??
                      'https://sharidah.sa/ecom/backend/public/storage/1121/961.jpeg'),
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
                      Expanded(
                        child: TextBody14(
                          orderItem.product?.name ?? 'هودي بسوستة',
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        TextDescription(
                          '(${orderItem.product?.rate ?? 0})',
                        ),
                        SvgPicture.asset(AppAssets.star),
                      ]),
                    ],
                  ),
                  TextBody12(
                    '${orderItem.total ?? 0} ر.س',
                    color: AppColors.black,
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
                            orderItem.colorCode ?? '#FFFFFF',
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
                    TextBody12(
                      'العدد : ${orderItem.quantity ?? 0} قطع',
                      fontSize: 10.sp,
                    ),
                  ]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextBody12('المقاس'),
                      SizedBox(width: 28.w),
                      TextBody12(
                        '${orderItem.sizeCode ?? ''}',
                      ),
SizedBox(width: 14.w),                      Flexible(
                        child: TextBody14(
                          overflow: TextOverflow.ellipsis,
                          'تاريخ الطلب : ${orderItem.createdAt ?? ''}',
                          fontSize: 10.sp,
                        ),
                      )
                    ],
                  ),
                  //SizedBox(height: 4.h),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBody12('حالة الطلب : ', color: AppColors.black),
                      BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                        final cubit = CartCubit.get(context);
                        return TextBody12(
                          cubit.localizeStatus(orderItem.status ?? ''),
                          color: cubit.statusColor(orderItem.status ?? ''),
                        );
                      }),
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
