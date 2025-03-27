import 'package:ecommerce/view/screens/cart/cart_screen.dart';
import 'package:ecommerce/view/screens/categories/main_categories/main_categories_screen.dart';
import 'package:ecommerce/view/screens/home/main_screen/main_screen.dart';
import 'package:ecommerce/view_model/cubits/brands/brand_cubit.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../view_model/cubits/connectivity/connectivity_cubit.dart';
import '../../../view_model/cubits/home/bottom_nav_cubit.dart';
import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/app_assets/app_assets.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';
import '../../common_components/custom_button/custom_button.dart';
import '../cart/components/check_out_component/check_out_component.dart';
import '../no_connection/no_connection.dart';
import '../others/others_screen.dart';
import '../start_design_screen/start_design_screen.dart';
import 'bottom_nav_bar/components/custom_nav_bar.dart';
import 'bottom_nav_bar/components/home_app_bar/home_app_bar.dart';
import 'bottom_nav_bar/components/search_bar/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        int currentIndex = BottomNavCubit.get(context).currentIndex;
        bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

        return BlocListener<ConnectivityCubit, ConnectivityState>(
          listener: (context, connectivityState) {
            if (connectivityState is ConnectivitySuccess) {
              if (!connectivityState.isConnected) {
                debugPrint('No Internet Connection');
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const NoConnectionScreen()),
                  (route) => false,
                );
              }
            } else if (connectivityState is ConnectivityFailure) {
              debugPrint(
                  'Connectivity check failed: ${connectivityState.message}');
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const NoConnectionScreen()),
                (route) => false,
              );
            }
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Scaffold(
                    resizeToAvoidBottomInset: false,
                    extendBodyBehindAppBar: true,
                    extendBody: true,
                    appBar: currentIndex != 0
                        ? null
                        : PreferredSize(
                            preferredSize: Size.fromHeight(40.h),
                            child: const HomeAppBar(),
                          ),
                    body: Stack(
                      children: [
                        currentIndex == 0
                            ? const MainScreen()
                            : currentIndex == 1
                                ? const StartDesignScreen()
                                : currentIndex == 2
                                    ? const MainCategoriesScreen()
                                    : currentIndex == 3
                                        ? const CartScreen()
                                        : const OthersScreen(),
                        if (!isKeyboardVisible)
                          Positioned(
                            bottom: 12.h,
                            left: 16.w,
                            right: 16.w,
                            child: CustomNavBar(
                              currentIndex: currentIndex,
                              onTap: (index) {
                                if (index == 2 &&
                                    BottomNavCubit.get(context).currentIndex !=
                                        2) {
                                  if (ProductsCubit.get(context)
                                      .sections
                                      .isEmpty) {
                                    ProductsCubit.get(context).getSections();
                                  }
                                } else if (index == 3 &&
                                    BottomNavCubit.get(context).currentIndex !=
                                        3) {
                                  CartCubit.get(context)
                                      .changeIsSelected(true, false);
                                  if (SharedHelper.getData(SharedKeys.token) !=
                                      null) {
                                    CartCubit.get(context).getCartItems();
                                  }
                                } else if (index == 0 &&
                                    BottomNavCubit.get(context).currentIndex !=
                                        0 &&
                                    ProductsCubit.get(context)
                                        .everyProducts
                                        .isEmpty) {
                                  BottomNavCubit.get(context).init();
                                  ProductsCubit.get(context).init();
                                  BrandCubit.get(context).getBrands();
                                }
                                /* else if (index == 4 &&
                                    BottomNavCubit.get(context).currentIndex !=
                                        4&& BottomNavCubit.get(context).settings.isEmpty){
                                  BottomNavCubit.get(context).getSettings();
                                }*/
                                BottomNavCubit.get(context).changeIndex(index);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: currentIndex == 0,
                    child: PositionedDirectional(
                      top: 0,
                      start: 56.w,
                      end: 0,
                      child: SizedBox(
                        width: double.infinity,
                        height: 5000.h,
                        // Explicit height ensures proper hit-testing
                        child: const CustomSearchBar(),
                      ),
                    ),
                  ),
/*
                  BlocBuilder<CartCubit, CartState>(
  builder: (context, state) {
    final cartCubit = CartCubit.get(context);
    return Visibility(
                    visible: BottomNavCubit.get(context).currentIndex == 3&&cartCubit.cartItems.isNotEmpty,
                    child: PositionedDirectional(
                      bottom: 70.h,
                      //start: 16.w,
                      end: 16.w,
                      child: Container(
                        height: 40.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.3),
                              // Shadow color
                              blurRadius: 5,
                              // Shadow blur radius
                              spreadRadius: 1,
                              // Shadow spread radius
                              offset: Offset(0, 3.h), // Shadow offset
                            ),
                          ],
                          gradient: LinearGradient(
                            // Gradient background
                            colors: [
                              HexColor('#31D3C6'),
                              HexColor('#208B78'),
                            ],
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          // Match the container's border radius
                          onTap: () {
                            // Show the bottom sheet
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return const CheckOutComponent();
                              },
                            );
                            debugPrint('توجه للدفع');
                          },
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBody14(
                                  'التوجه للدفع',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(width: 8.w),
                                SvgPicture.asset(AppAssets.buy),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
  },
),
*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
