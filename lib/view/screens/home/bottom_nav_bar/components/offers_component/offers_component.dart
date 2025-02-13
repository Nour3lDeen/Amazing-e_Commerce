import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/offers_component/product_card.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersComponent extends StatelessWidget {
  const OffersComponent({super.key, required this.title, required this.hasDiscount, required this.onTap});
final bool hasDiscount;
  final String title;
final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h,right: 16.w,left: 16.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: GestureDetector(
              onTap:onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTitle(
                    title,
                    color: AppColors.black,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      TextBody14(
                        'المزيد...',
                        color: AppColors.grey,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.grey,
                        size: 12.sp,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              spacing: 12.w,
              children:  [
                ProductCard(
                  title: 'قميص كاروهات',
                  image: 'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                  fromHome: true,
                  productId: 1,
                  hasDiscount: hasDiscount,
                ),
                ProductCard(
                  title: 'قميص كاروهات',
                  image: 'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                  fromHome: true,

                  productId: 2,
                  hasDiscount: hasDiscount,

                ),
                ProductCard(
                  title: 'قميص كاروهات',
                  image: 'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                  fromHome: true,
                  productId: 3,
                  hasDiscount: hasDiscount,

                ),
                ProductCard(
                  title: 'قميص كاروهات',
                  image: 'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                  fromHome: true,

                  productId: 4,
                  hasDiscount: hasDiscount,

                ),
                ProductCard(
                  title: 'قميص كاروهات',
                  image: 'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                  fromHome: true,
                  productId: 5,
                  hasDiscount: hasDiscount,

                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
