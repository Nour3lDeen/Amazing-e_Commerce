import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/translation/locale_keys.g.dart';
import 'package:ecommerce/view/screens/home/home_screen.dart';
import 'package:ecommerce/view/screens/others/profile/profile_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/brands/brand_cubit.dart';
import 'package:ecommerce/view_model/cubits/connectivity/connectivity_cubit.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/navigation/navigation.dart';
import '../no_connection/no_connection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 10),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward().then((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    // Initialize other Cubits
    BottomNavCubit.get(context).init();
    ProductsCubit.get(context).init();
    BrandCubit.get(context).getBrands();

    // Save platform information
    if (Platform.isAndroid) {
      await SharedHelper.saveData(SharedKeys.platform, 'android');
    } else if (Platform.isIOS) {
      await SharedHelper.saveData(SharedKeys.platform, 'ios');
    }

    // Handle login state
    if (SharedHelper.getData(SharedKeys.isLogged) == false) {
      await SharedHelper.removeKey(SharedKeys.token);
      await SharedHelper.removeKey(SharedKeys.gender);
    } else {
      await AuthCubit.get(context).init();
    }

    /*final connectivityCubit = ConnectivityCubit.get(context);
    await connectivityCubit.checkConnectivity();


    connectivityCubit.stream.listen((state) {
      if (!mounted) return;

      if (state is ConnectivitySuccess) {
        if (state.isConnected) {
          debugPrint('Connected to the Internet');
          Navigation.pushAndRemove(context, const HomeScreen());
        } else {
          debugPrint('No Internet Connection');
          Navigation.pushAndRemove(context, const NoConnectionScreen());
        }
      }
    });*/
    Navigation.pushAndRemove(context, const HomeScreen());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SvgPicture.asset(
              AppAssets.background,
              fit: BoxFit.cover,
            ),
          ),
          // Centered content (Logo & Text Animation)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _logoAnimation,
                  child: SvgPicture.asset(
                    'assets/svgs/white_logo.svg',
                    height: 70.h,
                  ),
                ),
                SizedBox(height: 8.h),
                SlideTransition(
                  position: _textAnimation,
                  child: TextTitle(
                    LocaleKeys.slogan.tr(),
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          // ✅ Loading indicator at the bottom
          /* if (_showLoading)
            Positioned(
              bottom: 40.h, // Adjust position
              left: 0,
              right: 0,
              child: Column(
                children: [
                  LoadingAnimationWidget.inkDrop(
                      color: AppColors.primaryColor, size: 15.sp),
                  SizedBox(height: 8.h),
                  TextTitle(
                    'يرجى الانتظار\nيتم تحميل المنتجات',
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ],
              ),
            ),*/
        ],
      ),
    );
  }
}
