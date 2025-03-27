import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/view/screens/home/home_screen.dart';
import 'package:ecommerce/view/screens/no_connection/no_connection.dart';
import 'package:ecommerce/view/screens/splash/splash_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/brands/brand_cubit.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/cubits/connectivity/connectivity_cubit.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/cubits/start_design/start_design_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // ignore: avoid_redundant_argument_values
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => BottomNavCubit()),
            BlocProvider(create: (context) => StartDesignCubit()),
            BlocProvider(create: (context) => ProductsCubit()),
            BlocProvider(create: (context) => CartCubit()),
            BlocProvider(create: (context) => BrandCubit()),
            BlocProvider(
                create: (context) => ConnectivityCubit()
                  ..init()),
          ],
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: child,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
