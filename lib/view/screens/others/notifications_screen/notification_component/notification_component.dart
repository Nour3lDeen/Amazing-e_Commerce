import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../view_model/utils/app_colors/app_colors.dart';

class NotificationComponent extends StatelessWidget {
  const NotificationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 1.h,
      ),
      child: Container(
          width: double.infinity,
          height:60.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            // borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: Offset(0.0, 3.h),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            offset: Offset(0.0, 3.h),
                            blurRadius: 6.0,
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: Image.asset(AppAssets.trailer).image)),
                    child: CircleAvatar(
                        backgroundImage: Image.asset(AppAssets.trailer).image,
                        radius: 18.r,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                            child: Image.asset(
                          AppAssets.trailer,
                          fit: BoxFit.cover,
                        ))),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextBody14('منتجك في مرحلة التحضير '),
                      SizedBox(height: 4.h),
                      const TextBody12('تم مراجعة منتجكم وجاري تحضيره')
                    ],
                  ),
                  const Spacer(),
                  const TextDescription('منذ 4 ساعات')
                ]),
          )),
    );
  }
}
