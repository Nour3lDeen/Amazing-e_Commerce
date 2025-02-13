import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/translation/locale_keys.g.dart';
import 'package:ecommerce/view/screens/home/home_screen.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/navigation/navigation.dart';

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

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (Platform.isAndroid) {
        SharedHelper.saveData(SharedKeys.platform, 'android');
        debugPrint('This device is running ${SharedHelper.getData(SharedKeys.platform)}');
      } else if (Platform.isIOS) {
        SharedHelper.saveData(SharedKeys.platform, 'ios');
        debugPrint('This device is running ${SharedHelper.getData(SharedKeys.platform)}');
      }
      if (SharedHelper.getData(SharedKeys.isLogged) == false) {
        SharedHelper.removeKey(SharedKeys.token);
      }
      Navigation.pushAndRemove(context, const HomeScreen());
    });
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
          // Background
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SvgPicture.asset(
              AppAssets.background,
              fit: BoxFit.cover,
            ),
          ),
          // Animated content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated logo
                SlideTransition(
                  position: _logoAnimation,
                  child: SvgPicture.asset(
                    'assets/svgs/white_logo.svg',
                    height: 70.h,
                  ),
                ),
                SizedBox(height: 8.h),
                // Animated text
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
        ],
      ),
    );
  }
}
