import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/cart_item_model/history_cart_model.dart';
import 'package:ecommerce/model/returned/returned_model.dart';
import 'package:ecommerce/view/screens/others/refund_requests/refund_details_screen.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/utils/app_colors/app_colors.dart';

class RefundCard extends StatelessWidget {
  const RefundCard({super.key, required this.returnedItem});

  final ReturnedModel returnedItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.push(
            context,
            RefundDetailsScreen(
              fromCart: false,
              returnedItem: returnedItem,
              orderItem: OrderItems(),
            ));
      },
      child: Container(
        height: 100.h,
        width: double.infinity,
        padding: EdgeInsets.only(right: 4.w, left: 8.w, bottom: 4.h, top: 4.h),
        decoration: BoxDecoration(
            color: HexColor('#DCDCDC'),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.15),
                blurRadius: 6,
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
                  image: CachedNetworkImageProvider(
                      returnedItem.orderItem?.colorImage ?? 'https://sharidah.sa/ecom/backend/public/storage/2006/1000.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                spacing: 4.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextBody14(
                          '${returnedItem.orderItem?.product?.name}',
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      TextBody12(
                        '${returnedItem.orderItem?.total} ر.س',
                        color: AppColors.black,
                      ),
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
                            '${returnedItem.orderItem?.colorCode??'#000000'}',
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
                        //visible: isHistory,
                        child: TextBody12(
                      'القطع المسترجعة : ${returnedItem.orderItem?.quantity} قطع',
                      fontSize: 10.sp,
                    )),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextBody12('المقاس'),
                      SizedBox(width: 30.w),
                      TextBody14('${returnedItem.orderItem?.sizeCode}',
                          fontSize: 12.sp),
                      const Spacer(),
                      TextDescription(
                        'تاريخ الطلب : ${returnedItem.createdAt}',
                        fontSize: 10.sp,
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextBody12(
                      'حالة الطلب :   ',
                      color: AppColors.black,
                    ),
                    TextBody14(
                      CartCubit.get(context)
                          .localizeStatus(returnedItem.status ?? ''),
                      fontSize: 12.sp,
                      color: CartCubit.get(context)
                          .statusColor(returnedItem.status ?? '#ffffff'),
                    )
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
