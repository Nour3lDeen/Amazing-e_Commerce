import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/navigation/navigation.dart';
import '../auth/login_screen/login_screen.dart';

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

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Define the animations
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      // Logo starts completely off-screen at the top
      end: Offset.zero, // Ends at the center
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 10),
      // Text starts completely off-screen at the bottom
      end: Offset.zero, // Ends at the center
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation
    _controller.forward();

    // Navigate to the next screen after a delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigation.pushAndRemove(context, const LoginScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free resources
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
                    AppAssets.logo,
                    height: 40.h, // Increased for better visibility
                  ),
                ),
                SizedBox(height: 8.h), // Add space between logo and text
                // Animated text
                SlideTransition(
                  position: _textAnimation,
                  child: TextTitle(
                    'خلاقين\n ونمتلك القيادة في مجال الأزياء',
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    // fontFamily: 'Lamar',
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
