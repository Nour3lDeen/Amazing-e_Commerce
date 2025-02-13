import 'package:ecommerce/view/screens/others/refund_requests/refund_details_screen.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/utils/app_colors/app_colors.dart';

class RefundCard extends StatelessWidget {
  const RefundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigation.push(context, const RefundDetailsScreen(fromCart: false,));
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
                  image: Image.asset(AppAssets.section4).image,
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
                      TextBody14(
                        'هودي بسوستة',
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Spacer(),
                      TextBody12(
                        '55 ر.س',
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
                            '#000000',
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
                      'القطع المسترجعة : 5 قطع',
                      fontSize: 10.sp,
                    )),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextBody12('المقاس'),
                      SizedBox(width: 30.w),
                      TextBody14('L'),
                      const Spacer(),
                      TextDescription(
                        'تاريخ الطلب : 15/12/2024',
                        fontSize: 10.sp,
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    TextBody12(
                      'حالة الطلب :   ',
                      color: AppColors.black,
                    ),TextBody14('قيد المراجعة',color: Colors.blue,)
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
