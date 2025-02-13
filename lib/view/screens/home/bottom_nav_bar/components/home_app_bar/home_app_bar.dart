import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/view/screens/others/profile/profile_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../../view_model/utils/Texts/Texts.dart';
import '../../../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../../auth/login_screen/login_screen.dart';
import '../../../../others/notifications_screen/notifications_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AppBar(
          primary: true,
          centerTitle: false,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: HexColor('#DCDCDC').withValues(alpha: 0.7),
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          bottomOpacity: 1.0,
          elevation: 0.h,
          leadingWidth: 130.w,
          toolbarHeight: 60.h,
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: InkWell(
                onTap: () {
                  Navigation.push(context, const NotificationsScreen());
                },
                borderRadius: BorderRadius.circular(25.r),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 16.r,
                  child: SvgPicture.asset(
                    AppAssets.notification,
                    height: 24.sp,
                  ),
                ),
              ),
            )
          ],
          leading: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              spacing: 6.w,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () {
                    if (SharedHelper.getData(SharedKeys.token) != null) {
                      /*showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      SharedHelper.getData(SharedKeys.avatar)
                                          .replaceFirst('http://', 'https://'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          });*/
                      Navigation.push(context, ProfileScreen());
                    }
                  },
                  child: Hero(
                    tag: 'avatar',

                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 16.r,
                      child: SharedHelper.getData(SharedKeys.token) == null
                          ? ClipOval(
                              child: Image.asset(
                              AppAssets.avatar,
                              height: 38.h,
                              width: 38.w,
                              fit: BoxFit.cover,
                            ))
                          : ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: SharedHelper.getData(SharedKeys.avatar)
                                    .replaceFirst('http://', 'https://'),
                                height: 38.h,
                                width: 38.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: SharedHelper.getData(SharedKeys.token) == null,
                      child: GestureDetector(
                        onTap: () {
                          Navigation.push(context, const LoginScreen());
                        },
                        child: Hero(
                          tag: 'login',
                          transitionOnUserGestures: true,
                          child: Material(
                            color: Colors.transparent,
                            child: TextBody14(
                              'تسجيل\nدخول',
                              color: AppColors.primaryColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: SharedHelper.getData(SharedKeys.token) != null,
                      child: TextBody14(
                        'مرحبًا بك',
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Visibility(
                      visible: SharedHelper.getData(SharedKeys.token) != null,
                      child: TextBody12(
                        SharedHelper.getData(SharedKeys.firstName) ??
                            'تسجيل دخول',
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
