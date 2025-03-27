import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view/screens/auth/login_screen/login_screen.dart';
import 'package:ecommerce/view/screens/others/address/address_screen.dart';
import 'package:ecommerce/view/screens/others/components/others_card/others_card.dart';
import 'package:ecommerce/view/screens/others/conatct_us/contact_us.dart';
import 'package:ecommerce/view/screens/others/policies/privacy_policy/privacy_policy_screen.dart';
import 'package:ecommerce/view/screens/others/policies/refund_policy/refund_policy.dart';
import 'package:ecommerce/view/screens/others/profile/profile_screen.dart';
import 'package:ecommerce/view/screens/others/refund_requests/refund_request_screen.dart';
import 'package:ecommerce/view/screens/others/wallet/wallet_screen.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../view_model/data/local/shared_keys.dart';
import '../../../view_model/utils/app_assets/app_assets.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';
import '../../common_components/not_logged_component/not_logged_component.dart';
import '../brands_sceen/brands_screen.dart';
import 'components/logout_component/logout_component.dart';
import 'conatct_us/chat.dart';
import 'favourites_screen/favourites_screen.dart';
import 'notifications_screen/notifications_screen.dart';

class OthersScreen extends StatelessWidget {
  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // final authCubit = AuthCubit.get(context);
        bool isLoggedIn = SharedHelper.getData(SharedKeys.token) != null;
        return Stack(
          children: [
            PositionedDirectional(
              start: 0,
              top: 0.h,
              end: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical:
                        SharedHelper.getData(SharedKeys.platform) == 'android'
                            ? 52.h
                            : 68.h),
                width: double.infinity,
                height: 240.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: Image.asset(AppAssets.othersBack).image,
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    BlocBuilder<BottomNavCubit, BottomNavState>(
                      builder: (context, state) {
                        if (SharedHelper.getData(SharedKeys.mainLogo) != null) {
                          if (SharedHelper.getData(SharedKeys.mainLogo)
                                  .split('.')
                                  .last
                                  .toLowerCase() !=
                              'svg') {
                            return CachedNetworkImage(
                              imageUrl:
                                  SharedHelper.getData(SharedKeys.mainLogo),
                              height: 30.h,
                              width: 30.h,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              placeholder: (context, url) =>
                                  LoadingAnimationWidget.inkDrop(
                                      color: AppColors.primaryColor,
                                      size: 30.sp),
                            );
                          } else {
                            return SvgPicture.network(
                              SharedHelper.getData(SharedKeys.mainLogo),
                              height: 26.h,
                              width: 26.h,
                            );
                          }
                        } else {
                          return SvgPicture.asset(
                            'assets/svgs/others_logo.svg',
                            height: 48.h,
                            width: 48.h,
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    BlocBuilder<BottomNavCubit, BottomNavState>(
                      builder: (context, state) {
                        final bottomNavCubit = BottomNavCubit.get(context);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8.w,
                          children: List.generate(
                              bottomNavCubit.socialLinks.length, (index) {
                            return InkWell(
                              onTap: () async {
                                final url = bottomNavCubit
                                    .socialLinks[index].socialLink;
                                if (url != null && url.isNotEmpty) {
                                  final uri = Uri.parse(url);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    debugPrint('❌ Could not launch $url');
                                  }
                                }
                              },
                              child: Container(
                                height: 20.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black
                                            .withValues(alpha: 0.1),
                                        blurRadius: 4,
                                        offset: Offset(1.w, 3.h),
                                      )
                                    ]),
                                child: bottomNavCubit
                                            .socialLinks[index].socialIcon
                                            ?.split('.')
                                            .last
                                            .toLowerCase() !=
                                        'svg'
                                    ? CachedNetworkImage(
                                        imageUrl: bottomNavCubit
                                                .socialLinks[index]
                                                .socialIcon ??
                                            '',
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                        placeholder: (context, url) =>
                                            LoadingAnimationWidget.inkDrop(
                                                color: AppColors.primaryColor,
                                                size: 10.sp),
                                      )
                                    : SvgPicture.network(
                                        placeholderBuilder: (context) =>
                                            LoadingAnimationWidget.inkDrop(
                                                color: AppColors.primaryColor,
                                                size: 20.sp),
                                        bottomNavCubit.socialLinks[index]
                                                .socialIcon ??
                                            '',
                                      ),
                              ),
                            );
                          }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              start: 0,
              top: 170.h,
              bottom: 0,
              end: 0,
              child: ClipRRect(
                // clipBehavior:Clip.none,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r)),
                      color: AppColors.white.withValues(alpha: 0.6),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.asset(
                          AppAssets.customBack,
                          height: double.infinity,
                          width: double.infinity,
                        ).image,
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.h,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 4.h),
                            child: Visibility(
                              visible: isLoggedIn,
                              replacement: GestureDetector(
                                onTap: () => Navigation.push(
                                    context, const LoginScreen()),
                                child: Hero(
                                  tag: 'login',
                                  transitionOnUserGestures: true,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: TextTitle(
                                      'تسجيل الدخول',
                                      color: AppColors.primaryColor,
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.15),
                                          offset: Offset(0.0, 3.h),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                              child: Row(children: [
                                GradientText(
                                  'مرحبًا بك',
                                  gradient: LinearGradient(colors: [
                                    HexColor('#D1C100'),
                                    HexColor('#F3EB88'),
                                  ]),
                                  strokeColor: Colors.black,
                                  strokeWidth: 1,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                TextBody14(
                                  SharedHelper.getData(SharedKeys.firstName) ??
                                      '',
                                )
                              ]),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              //physics: const ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 6.h,
                                children: [
                                  OthersCard(
                                      onTap: () {
                                        if (isLoggedIn) {
                                          Navigation.push(
                                              context, const ProfileScreen());
                                          debugPrint('profile');
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return const NotLoggedComponent();
                                            },
                                          );
                                        }
                                      },
                                      title: 'الملف اللشخصي',
                                      icon: AppAssets.profile),
                                  OthersCard(
                                      title: 'علاماتنا التجارية',
                                      onTap: () => Navigation.push(
                                            context,
                                            const BrandsScreen(),
                                          ),
                                      icon: AppAssets.brands),
                                  OthersCard(
                                      onTap: () {
                                        if (isLoggedIn) {
                                          Navigation.push(
                                            context,
                                            const NotificationsScreen(),
                                          );
                                          debugPrint('notifications');
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return const NotLoggedComponent();
                                            },
                                          );
                                        }
                                      },
                                      title: 'الإشعارات',
                                      icon: AppAssets.ring),
                                  OthersCard(
                                      onTap: () {
                                        if (isLoggedIn) {
                                          ProductsCubit.get(context)
                                              .getFavorites();
                                          Navigation.push(
                                            context,
                                            const FavouritesScreen(),
                                          );
                                          debugPrint('favourites');
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return const NotLoggedComponent();
                                            },
                                          );
                                        }
                                      },
                                      title: 'المنتجات المفضلة',
                                      icon: AppAssets.favourite),
                                  OthersCard(
                                      onTap: () {
                                        if (isLoggedIn) {
                                          debugPrint(
                                              'Before calling getUserData: ${AuthCubit.get(context).state}');

                                          AuthCubit.get(context).getUserData();
                                          debugPrint(
                                              'After calling getUserData: ${AuthCubit.get(context).state}');

                                          Navigation.push(
                                              context, const AddressScreen());
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return const NotLoggedComponent();
                                            },
                                          );
                                        }
                                      },
                                      title: 'عناوين الشحن',
                                      icon: AppAssets.location),
                                  OthersCard(
                                      onTap: () {
                                        if (isLoggedIn) {
                                          Navigation.push(
                                              context, const WalletScreen());
                                          debugPrint('profile');
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return const NotLoggedComponent();
                                            },
                                          );
                                        }
                                      },
                                      title: 'رصيد المحفظة',
                                      icon: AppAssets.wallet),
                                  OthersCard(
                                      onTap: () {
                                        if (isLoggedIn) {
                                          debugPrint('refund');
                                          CartCubit.get(context)
                                              .getReturnedItems();
                                          Navigation.push(
                                            context,
                                            const RefundRequestScreen(),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return const NotLoggedComponent();
                                            },
                                          );
                                        }
                                      },
                                      title: 'طلبات الاسترجاع',
                                      icon: AppAssets.cloud1),
                                  OthersCard(
                                      onTap: () {
                                        Navigation.push(
                                          context,
                                          const RefundPolicy(),
                                        );
                                      },
                                      title: 'سياسة الاسترجاع',
                                      icon: AppAssets.policy),
                                  OthersCard(
                                      onTap: () {
                                        if (isLoggedIn) {
                                         /* if (false) {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const Chat(),
                                            );
                                          } else */{
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const ContactUs(),
                                            );
                                          }
                                          debugPrint('contact');
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return const NotLoggedComponent();
                                            },
                                          );
                                        }
                                      },
                                      title: 'تواصل معنا',
                                      icon: AppAssets.contact),
                                  OthersCard(
                                      onTap: () {
                                        Navigation.push(context,
                                            const PrivacyPolicyScreen());
                                      },
                                      title: 'سياسة الخصوصية',
                                      icon: AppAssets.privacy),
                                  Visibility(
                                    visible: isLoggedIn,
                                    child: SizedBox(
                                      height: 8.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: isLoggedIn,
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.15),
                                              offset: Offset(0.0, 3.h),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          child: CustomButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    transitionAnimationController:
                                                        AnimationController(
                                                      vsync:
                                                          Scaffold.of(context),
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                    ),
                                                    context: context,
                                                    builder: (context) {
                                                      return const LogoutComponent();
                                                    });
                                                // authCubit.logout(context);
                                              },
                                              borderRadius: 8.r,
                                              gradient: LinearGradient(colors: [
                                                HexColor('#FD6C6C'),
                                                HexColor('#B84141'),
                                              ]),
                                              child: SizedBox(
                                                width: 160.w,
                                                height: 35.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextBody14(
                                                      'تسجيل الخروج',
                                                      color: AppColors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    SvgPicture.asset(
                                                        AppAssets.logout)
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: SharedHelper.getData(
                                                  SharedKeys.platform) ==
                                              'ios'
                                          ? 50.h
                                          : 70.h),
                                ],
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              end: 28.w,
              top: 135.h,
              child: Hero(
                tag: 'avatar',
                child: GestureDetector(
                  onTap: () {
                    if (isLoggedIn) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: AuthCubit.get(context).selectedImage ==
                                        null
                                    ? CachedNetworkImage(
                                        imageUrl: SharedHelper.getData(
                                                SharedKeys.avatar)
                                            .replaceFirst(
                                                'http://', 'https://'),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        AuthCubit.get(context).selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            );
                          });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 35.r,
                      child: isLoggedIn
                          ? ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    SharedHelper.getData(SharedKeys.avatar)
                                        .replaceFirst('http://', 'https://'),
                                height: 70.h,
                                width: 70.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.asset(
                              AppAssets.avatar,
                              height: 70.h,
                              width: 70.w,
                              fit: BoxFit.cover,
                            )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
