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
class ProductRefundScreen extends StatelessWidget {
  const ProductRefundScreen({super.key});

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
                          'سياسة استرجاع المنتج',
                          fontSize: 18.sp,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 8.h,),
                        TextBody14(
                          textAlign: TextAlign.center,
                          'نحن في Amazing نهدف إلى ضمان رضاك التام عن مشترياتك. إذا لم تكن راضياً عن المنتج الذي اشتريته، يمكنك استرجاعه خلال 14 يومًا من تاريخ استلام الطلب وفق الشروط التالية:',
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ),
                        SizedBox(height: 8.h,),
                       Expanded(child: SingleChildScrollView(
                         child: Column(
                           children: [
                             TextBody14( """
1) حالة المنتج:\n
يجب أن يكون المنتج بحالته الأصلية وغير مستخدم.\n
يجب أن يكون مغلفاً بنفس التغليف الأصلي مع وجود جميع العلامات والملصقات.\n\n
2) الفاتورة:\n
يُشترط تقديم الفاتورة أو إثبات الشراء عند تقديم طلب الاسترجاع.\n\n
3) المنتجات غير القابلة للاسترجاع:\n
المنتجات الداخلية (مثل الملابس الداخلية) لا يمكن استرجاعها لأسباب تتعلق بالصحة والسلامة.\n
المنتجات المخصّصة أو المُعدّلة بناءً على طلب العميل.\n\n
4) طريقة الاسترجاع:\n
يمكن استرجاع المنتج من خلال زيارة أحد فروعنا أو إرسال المنتج عبر شركة الشحن إلى عنواننا المحدد.\n
يتحمل العميل تكاليف الشحن في حالة عدم وجود خطأ أو عيب في المنتج.\n\n
5) استرداد الأموال:\n
سيتم استرداد المبلغ بنفس طريقة الدفع الأصلية خلال 7-14 يوم عمل بعد قبول طلب الاسترجاع.\n
إذا تم دفع الطلب نقداً (كاش)، سيتم التواصل معك لتنسيق استرداد المبلغ.\n\n
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
