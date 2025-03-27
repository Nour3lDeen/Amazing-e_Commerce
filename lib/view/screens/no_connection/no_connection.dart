import 'package:ecommerce/view/screens/home/home_screen.dart';
import 'package:ecommerce/view_model/cubits/connectivity/connectivity_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../view_model/cubits/brands/brand_cubit.dart';
import '../../../view_model/cubits/home/bottom_nav_cubit.dart';
import '../../../view_model/cubits/products/products_cubit.dart';
import '../../../view_model/utils/app_assets/app_assets.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivitySuccess && state.isConnected) {
          BottomNavCubit.get(context).init();
          ProductsCubit.get(context).init();
          BrandCubit.get(context).getBrands();
          Navigation.pushAndRemove(context, const HomeScreen());
        }
      },
      builder: (context, state) {
        final cubit = ConnectivityCubit.get(context);
        final isLoading = state is ConnectivityLoading;

        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.back),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              spacing: 6.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.noConnection),
                TextBody14(
                  'أنت غير متصل بالإنترنت .. \n تأكد من اتصالك بالإنترنت وأعد المحاولة',
                  color: AppColors.primaryColor,
                  fontSize: 16.sp,
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    if (!isLoading) {
                      cubit.checkConnectivity(); // Check connectivity
                    }
                  },
                  child: isLoading
                      ? LoadingAnimationWidget.inkDrop(
                          color: AppColors.primaryColor, size: 20.sp)
                      : Container(
                          height: 32.h,
                          width: 150.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                offset: Offset(0.0, 3.h),
                                blurRadius: 6.0,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                HexColor('#31D3C6'),
                                HexColor('#208B78')
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 6.w,
                            children: [
                              TextBody14(
                                'إعادة المحاولة',
                                color: AppColors.white,
                                fontSize: 16.sp,
                              ),
                              SvgPicture.asset(AppAssets.reload),
                            ],
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
