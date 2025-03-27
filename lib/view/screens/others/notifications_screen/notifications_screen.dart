import 'package:ecommerce/view/common_components/custom_app_bar/custom_app_bar.dart';
import 'package:ecommerce/view/screens/brands_sceen/brands_screen.dart';
import 'package:ecommerce/view_model/cubits/brands/brand_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../view_model/data/local/shared_keys.dart';
import 'notification_component/notification_component.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
      builder: (context, state) {
        final brandCubit = BrandCubit.get(context);
        return Scaffold(
          body: Stack(children: [
            Container(
              padding: EdgeInsets.only(
                  // horizontal: 16.w,
                  top: SharedHelper.getData(SharedKeys.platform) == 'ios'
                      ? 40.h
                      : 50.h,
                  bottom: 24.h),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(AppAssets.back),
                fit: BoxFit.cover,
              )),
              child: ListView(
                controller: brandCubit.scrollController,
                clipBehavior: Clip.none,
                children: const [
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                  NotificationComponent(),
                ],
              ),
            ),
            const CustomAppBar(
              title: 'الإشعارات',
              isOffers: true,
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
