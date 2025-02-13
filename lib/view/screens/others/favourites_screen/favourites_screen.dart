import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../view_model/cubits/brands/brand_cubit.dart';
import '../../../../view_model/data/local/shared_helper.dart';
import '../../../../view_model/data/local/shared_keys.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../common_components/custom_app_bar/custom_app_bar.dart';
import '../../home/bottom_nav_bar/components/offers_component/product_card.dart';
import '../notifications_screen/notification_component/notification_component.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
      builder: (context, state) {
        final brandCubit = BrandCubit.get(context);
        return Scaffold(
          body: Stack(children: [
            Container(
              padding: EdgeInsets.symmetric(
                 horizontal: 16.w,
                  vertical: SharedHelper.getData(SharedKeys.platform) == 'ios'
                      ? 40.h
                      : 8.h),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.back),
                    fit: BoxFit.cover,
                  )),
              child: ListView(
                controller: brandCubit.scrollController,
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Row(

                        spacing: 4.w,
                        children: List.generate(
                          4,
                              (index) => Container(
                                width: 70.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.sp),
                            decoration: BoxDecoration(
                              gradient: index == 0
                                  ? LinearGradient(colors: [
                                HexColor('#49F2D5'),
                                HexColor('#09AC90'),
                              ])
                                  : null,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: TextBody12(
                                index == 0 ? 'الكل' : 'رجالي',
                                color: index == 0
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16.w,
                      runSpacing: 16.h,
                      children: List.generate(
                        50,
                            (index) => ProductCard(
                            productId: index,
                            hasDiscount: false,
                            title: 'قميص كاروهات',
                            image:
                            'http://minscp.com/ecom/backend/public/storage/801/0U4A5271.jpg',
                            fromHome: true),
                      ))
                ],
              ),
            ),
            CustomAppBar(
              title: 'منتجاتك المفضلة',
              isOffers: false,
              hasSeasonsDropDown: false,
            ),
            PositionedDirectional(
              top: 48.h,
              start: 0.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(
                    decoration:
                    BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: Offset(0, 1),
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
          ]),
        );
      },
    );
  }
}
