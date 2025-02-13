import 'package:ecommerce/view/screens/cart/cart_screen.dart';
import 'package:ecommerce/view/screens/categories/main_categories/main_categories_screen.dart';
import 'package:ecommerce/view/screens/home/main_screen/main_screen.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_model/cubits/home/bottom_nav_cubit.dart';
import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/app_assets/app_assets.dart';
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
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true,
                  appBar: currentIndex != 0
                      ? null
                      : PreferredSize(
                          preferredSize: Size.fromHeight(48.h),
                          child:
                              const SafeArea(top: true, child: HomeAppBar())),
                  body: Stack(
                    children: [
                      currentIndex == 0
                          ?  MainScreen()
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
                                ProductsCubit.get(context).getSections();
                              } else if (index == 3 &&
                                  BottomNavCubit.get(context).currentIndex !=
                                      3) {
                                CartCubit.get(context).getCartItems();
                              }
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
                    top: 8,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
