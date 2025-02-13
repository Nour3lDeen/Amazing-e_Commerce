import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/view/screens/home/bottom_nav_bar/components/offers_component/product_card.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../view_model/cubits/brands/brand_cubit.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';
import '../../common_components/custom_app_bar/custom_app_bar.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.back),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<BrandCubit, BrandState>(
              builder: (context, state) {
                final cubit = context.read<BrandCubit>();
                return ListView(
                    padding: EdgeInsets.only(top: 90.h),
                    clipBehavior: Clip.none,
                    controller: cubit.scrollController,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform.translate(
                            offset: Offset(0, -12.h),
                            child: InkWell(
                              onTap: cubit.nextPage,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20.sp,
                                color: AppColors.primaryColor,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.25),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 75.w,
                            height: 80.h,
                            child: CarouselSlider(
                              // disableGesture: true,
                              carouselController: cubit.carouselController,
                              items: List.generate(
                                cubit.brands.length,
                                (index) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cubit.setPage(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: index == state.currentIndex
                                              ? Border.all(
                                                  color: HexColor('#71FAE3'),
                                                  width: 2,
                                                )
                                              : Border.all(
                                                  color: AppColors.white,
                                                  width: 1.5,
                                                ),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          boxShadow: index == state.currentIndex
                                              ? [
                                                  BoxShadow(
                                                    color: HexColor('#39FAD9')
                                                        .withValues(alpha: 0.2),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 5.h),
                                                  ),
                                                ]
                                              : [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(
                                                            alpha: 0.25),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: 50.h,
                                                width: 90.w,
                                                child: Image.asset(
                                                  cubit.brands[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              if (index != state.currentIndex)
                                                Positioned.fill(
                                                  child: Container(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.6),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    TextBody14(
                                      'براند ${index + 1}',
                                      color: index == state.currentIndex
                                          ? AppColors.black
                                          : AppColors.black,
                                      fontWeight: index == state.currentIndex
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                              options: CarouselOptions(
                                // scrollPhysics: const BouncingScrollPhysics(),
                                viewportFraction: 0.25.w,
                                enableInfiniteScroll: true,
                                animateToClosest: true,
                                autoPlay: false,
                                reverse: true,
                                enlargeCenterPage: true,

                                scrollDirection: Axis.horizontal,
                                pageSnapping: true,
                                initialPage: state.currentIndex,
                                onPageChanged: (index, reason) {
                                  cubit.setPage(index);
                                },
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(-3.w, -12.h),
                            child: InkWell(
                              onTap: () {
                                cubit.previousPage();
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20.sp,
                                color: AppColors.primaryColor,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.25),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: DropdownButton(
                          items: [
                            DropdownMenuItem(
                              value: 1,
                              child: TextBody14(
                                'رجالي',
                                color: AppColors.black,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: TextBody14(
                                'أطفالي',
                                color: AppColors.black,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: TextBody14(
                                'نسائي',
                                color: AppColors.black,
                              ),
                            ),
                          ],
                          value: null,
                          hint: Container(
                            height: 28.h,
                            width: 128.w,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: LinearGradient(
                                colors: [
                                  HexColor('#31D3C6'),
                                  HexColor('#208B78'),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBody14(
                                  'رجالي',
                                  color: AppColors.white,
                                ),
                                SizedBox(width: 4.w),
                                SvgPicture.asset(
                                  AppAssets.arrowDown,
                                  height: 10.h,
                                  width: 10.w,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          iconSize: 0,
                          onChanged: (value) {
                            // Handle value change
                            debugPrint("Selected value: $value");
                          },
                          dropdownColor: Colors.white,
                          underline: SizedBox.shrink(),
                          borderRadius: BorderRadius.circular(8.r),
                          //isExpanded: true,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 4.w,
                          children: List.generate(
                            6,
                            (index) => Container(
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
                                  index == 0 ? 'جميع المنتجات' : 'قميص',
                                  color: index == 0
                                      ? AppColors.white
                                      : AppColors.black,
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
                    ]);
              },
            ),
          ),
          CustomAppBar(
            title: 'علاماتنا التجارية',
            isOffers: false,
            hasSeasonsDropDown: true,
          ),
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
        ],
      ),
    );
  }
}
