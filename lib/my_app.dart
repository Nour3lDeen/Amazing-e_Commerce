import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/view/screens/splash/splash_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
            providers: [
            BlocProvider(create: (context) => AuthCubit()),
        ],
        child: MaterialApp(
           /* localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,*/
            home: child,
            debugShowCheckedModeBanner: false,

        ));
      },
      child: const SplashScreen(),
    );
  }
}