import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/view/screens/brands_sceen/brands_screen.dart';
import 'package:ecommerce/view/screens/categories/offers_screen/offers_screen.dart';
import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/offers_component/offers_component.dart';
import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/start_design/start_design_component.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class MainScreen extends StatelessWidget {
  final List<String> brands = List.generate(
    17,
        (index) => 'assets/images/brand${index + 1}.jpeg', // Add paths dynamically
  );
   MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(AppAssets.back).image,
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Image.asset(
                  AppAssets.header,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Image.asset(
                  AppAssets.trailer,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Image.asset(
                  AppAssets.trailer2,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Image.asset(
                  AppAssets.trailer3,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Image.asset(
                  AppAssets.trailer4,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ],
              options: CarouselOptions(
                height: 300.h,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollPhysics: const BouncingScrollPhysics(),
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                onPageChanged: (index, reason) {
                  // Optional: Add logic for page change
                },
              ),
            ),
           // SizedBox(height: 8.h),
            ClipRRect(
              child: InkWell(
                onTap: (){
                  Navigation.push(context, BrandsScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.10),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:  Offset(0, 5),
                      ),
                    ],
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: CarouselSlider(
                      items: List.generate(
                        brands.length,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 6.h),
                              child: Image.asset(
                                brands[index],
                                //height: 30.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                      ),
                      options: CarouselOptions(
                        height: 60.h,
                        viewportFraction: 0.25,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(milliseconds: 100),
                        autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                        autoPlayCurve: Curves.linear,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const StartDesignComponent(),
            OffersComponent(
              title: 'عروض Amazing',
              hasDiscount: true,
              onTap: () {
                Navigation.push(context, OffersScreen());
              },
            ),
            SizedBox(height: 8.h),
            TextTitle(
              'المنتجات الأكثر مبيعًا',
              color: AppColors.primaryColor,
              fontSize: 18.sp,
            ),
            OffersComponent(
              title: 'رجالي',
              hasDiscount: false,
              onTap: () {},
            ),
            OffersComponent(
              title: 'نسائي',
              hasDiscount: false,
              onTap: () {},
            ),
            OffersComponent(
              title: 'أطفالي',
              hasDiscount: false,
              onTap: () {},
            ),
            Container(height: 70.h, color: Colors.transparent),
          ],
        ),
      ),
    );
  }
}
