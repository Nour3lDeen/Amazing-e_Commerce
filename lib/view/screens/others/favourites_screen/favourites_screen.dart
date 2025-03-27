import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
                      : 30.h),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(AppAssets.back),
                fit: BoxFit.cover,
              )),
              child: ListView(
                controller: brandCubit.scrollController,
                padding: EdgeInsets.only(top: 50.h),
                clipBehavior: Clip.none,
                children: [
                  BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      final productsCubit = ProductsCubit.get(context);
                      if (state is SectionLoadingState ||
                          state is GetFavoritesLoadingState) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 250.h,
                            ),
                            Center(
                              child: LoadingAnimationWidget.inkDrop(
                                  color: AppColors.primaryColor, size: 25.sp),
                            ),
                          ],
                        );
                      }
                      if (productsCubit.favorites.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 250.h,
                            ),
                            Center(
                                child: TextTitle(
                              'لا يوجد منتجات مفضلة',
                              color: AppColors.primaryColor,
                            )),
                          ],
                        );
                      }
                      return Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 16.w,
                          runSpacing: 16.h,
                          children: List.generate(
                            productsCubit.favorites.length,
                            (index) => ProductCard(
                              productId: productsCubit.favorites[index].id!,
                              title: productsCubit.favorites[index].name ?? '',
                              image: productsCubit.favorites[index].colors?[0]
                                      .images?[0].url ??
                                  'https://img.freepik.com/photos-gratuite/iguane-jaune-gros-plan-visage-iguane-albinos-gros-plan_488145-3482.jpg?t=st=1742817188~exp=1742820788~hmac=7c1d0ef9f488f3613d3b8042e3914692fcaf17b5c84b33c95cceb96a1a3e737a&w=996',
                              fromHome: false,
                              product: productsCubit.favorites[index],
                            ),
                          ));
                    },
                  )
                ],
              ),
            ),
            const CustomAppBar(
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
                        blurRadius: 8,
                        offset: const Offset(0, 1),
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
