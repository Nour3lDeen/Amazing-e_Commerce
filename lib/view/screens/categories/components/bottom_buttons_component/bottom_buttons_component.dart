import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view/screens/home/home_screen.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../model/sections_model/sections_model.dart';
import '../../../../../view_model/data/local/shared_keys.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../../common_components/not_logged_component/not_logged_component.dart';
import '../../../auth/login_screen/login_screen.dart';
import '../../../cart/components/check_out_component/check_out_component.dart';

class BottomButtonsComponent extends StatelessWidget {
  const BottomButtonsComponent({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);

        return PositionedDirectional(
          bottom: 0,
          start: 0,
          end: 0,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: 90.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                        onPressed: () {
                          if (SharedHelper.getData(SharedKeys.token) == null) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return const NotLoggedComponent();
                              },
                            );
                          } else {
                            BottomNavCubit.get(context).changeIndex(3);
                            Navigation.pushAndRemove(
                                context, const HomeScreen());
                            CartCubit.get(context).getCartItems();
                            //Navigator.pop(context);
                          }
                        },
                        gradient: LinearGradient(colors: [
                          HexColor('#2BC339'),
                          HexColor('#049312'),
                        ]),
                        borderRadius: 10.r,
                        child: SizedBox(
                          height: 40.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBody14(
                                  'الذهاب للعربة',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                SvgPicture.asset(
                                  AppAssets.cart,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.white, BlendMode.srcIn),
                                  height: 18.h,
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Skeletonizer(
                      enabled: state is AddCartItemLoadingState,
                      child: CustomButton(
                          onPressed: () {
                            if (SharedHelper.getData(SharedKeys.token) ==
                                null) {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: Container(
                                      width: 240.w,
                                      height: 160.h,
                                      padding: EdgeInsets.all(12.sp),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.white,
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        image: DecorationImage(
                                          image: Image.asset(
                                                  AppAssets.containerBackground)
                                              .image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.error_outline_rounded,
                                            color: AppColors.primaryColor,
                                            size: 50.sp,
                                          ),
                                          TextBody14(
                                            'أنت لم تقم بتسجيل الدخول\nالتوجه لتسجيل الدخول؟',
                                            color: AppColors.black,
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigation.push(context,
                                                      const LoginScreen());
                                                },
                                                gradient:
                                                    LinearGradient(colors: [
                                                  HexColor(
                                                    '#31D3C6',
                                                  ),
                                                  HexColor(
                                                    '#208B78',
                                                  )
                                                ]),
                                                borderRadius: 8.r,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4.h),
                                                  child: SizedBox(
                                                    width: 95.w,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextBody12(
                                                          'تسجيل',
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                        SizedBox(width: 4.w),
                                                        SvgPicture.asset(
                                                          AppAssets.login,
                                                          height: 16.h,
                                                          width: 16.w,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              CustomButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context); // Close the dialog
                                                },
                                                backgroundColor:
                                                    AppColors.white,
                                                child: Container(
                                                  width: 95.w,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4.h),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextBody12(
                                                        'إلغاء',
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Icon(
                                                        Icons.cancel_outlined,
                                                        color: AppColors
                                                            .primaryColor,
                                                        size: 16.sp,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              cubit.addCartItem(context, product.id!);
                              debugPrint('Add To Cart');
                              //Navigator.pop(context);
                              /* cubit.viewToast(
                                      'تم الاضافة للعربة', context, Colors.green);*/
                            }
                          },
                          borderRadius: 10.r,
                          child: SizedBox(
                            height: 40.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextBody14(
                                    'إضافة للعربة',
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  SvgPicture.asset(AppAssets.addCart)
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
