import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/data/local/shared_helper.dart';
import '../../../../../view_model/data/local/shared_keys.dart';
import '../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class BalanceRefundScreen extends StatelessWidget {
  const BalanceRefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PositionedDirectional(
          start: 0,
          top: 0.h,
          end: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: SharedHelper.getData(SharedKeys.platform) == 'android'
                    ? 32.h
                    : 48.h),
            width: double.infinity,
            height: 240.h,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: Image.asset(AppAssets.othersBack).image,
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                offset: Offset(0.0, 1.h),
                                blurRadius: 15,
                                spreadRadius: 1),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppAssets.backIcon1,
                          height: 30.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70.w,
                    ),
                    GradientText(
                      'سياسة الإسترجاع',
                      gradient: LinearGradient(
                        colors: [
                          HexColor('#DCCF0F'),
                          HexColor('#8B8309'),
                        ],
                      ),
                      fontSize: 18.sp,
                    )
                  ],
                ),
                SvgPicture.asset(
                  AppAssets.policies,
                  height: 75.h,
                  width: 75.w,
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          start: 0,
          top: 170.h,
          bottom: 0,
          end: 0,
          child: ClipRRect(
            // clipBehavior:Clip.none,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r)),
                  color: AppColors.white.withValues(alpha: 0.6),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.asset(
                      AppAssets.customBack,
                      height: double.infinity,
                      width: double.infinity,
                    ).image,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextTitle(
                      'سياسة استرجاع الرصيد',
                      fontSize: 18.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextBody14(
                      textAlign: TextAlign.center,
                      'في Amazing نحرص على تقديم تجربة تسوق مميزة ومرنة، ولذلك وضعنا سياسة استرجاع الرصيد بالشروط التالية:',
                      fontSize: 16.sp,
                      color: AppColors.black,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextBody14("""
1) فترة استرجاع الرصيد:\n
يمكن للعملاء استرجاع الرصيد خلال فترة أقصاها سنتان (24 شهرًا) من تاريخ إضافته إلى الحساب.\n
بعد انتهاء هذه الفترة، لن يكون الرصيد صالحًا للاستخدام أو الاسترداد.\n\n
2) في حالة استرجاع المنتجات للحصول على الرصيد:\n
إذا تم إرجاع المنتج، سيُضاف إلى رصيد العميل 50% فقط من قيمة المنتج الأصلية.\n
يجب أن يكون المنتج بحالته الأصلية وغير مستخدم، ومغلفًا بنفس التغليف الأصلي.\n\n
3) آلية استرجاع الرصيد:\n
يتم إضافة الرصيد إلى حساب العميل في التطبيق أو يمكن تحويله إلى وسيلة الدفع الأصلية حسب الشروط المتفق عليها.\n
الرصيد المضاف يمكن استخدامه في عمليات الشراء المستقبلية فقط ولا يمكن تحويله إلى نقد.\n\n
4) شروط عامة:\n
تُطبّق هذه السياسة على المنتجات المسترجعة وفقاً لشروط الاسترجاع العامة المذكورة في سياسة الشركة.\n
الشركة تحتفظ بالحق في تعديل أو تحديث هذه السياسة وفقًا لمتطلبات العمل مع إخطار العملاء بأي تغييرات.\n\n
نشكرك على ثقتك بنا، ونسعى دائمًا لتقديم أفضل تجربة تسوق لك!\n
للاستفسار، يرجى التواصل مع خدمة العملاء عبر [رقم الهاتف أو البريد الإلكتروني].
""")
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
