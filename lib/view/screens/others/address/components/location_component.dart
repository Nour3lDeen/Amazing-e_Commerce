import 'dart:ui';

import 'package:ecommerce/model/auth/user.dart';
import 'package:ecommerce/view/screens/others/address/view_location.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../model/countries/countries_model.dart';
import '../../../../common_components/custom_button/custom_button.dart';
import '../add_address_screen.dart';

class LocationComponent extends StatelessWidget {
  const LocationComponent({super.key, required this.address});

  final Addresses address;

  @override
  Widget build(BuildContext context) {
    String _shortenDescription(String? description) {
      if (description == null || description.trim().isEmpty) return '';

      List<String> words = description.trim().split(' ');
      return words.length > 2 ? '${words.take(2).join(' ')} ...' : description;
    }

    return InkWell(
      onTap: () {
        Navigation.push(
            context,
            ViewLocation(
              address: address,
            ));
      },
      child: Container(
        height: 70.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: AppColors.othersColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: Offset(0.0, 3.h),
                blurRadius: 6.0,
              ),
            ],
            borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.location1),
            SizedBox(
              width: 6.w,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                TextBody14(
                  address.name ?? '',
                  fontWeight: FontWeight.bold,
                ),
                TextBody12(address.fullName ?? ''),
                TextBody12(
                  '${address.country} - ${address.city} - ${_shortenDescription(address.description)}',
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      AuthCubit.get(context).clearData();
                      AuthCubit.get(context).addressFullNameController.text =
                          address.fullName ?? '';
                      AuthCubit.get(context).addressNameController.text =
                          address.name ?? '';
                      AuthCubit.get(context).addressDescriptionController.text =
                          address.description ?? '';
                      AuthCubit.get(context).addressPhoneController.text =
                          address.mobile ?? '';
                      AuthCubit.get(context).addressOtherPhoneController.text =
                          address.otherMobile ?? '';
                      AuthCubit.get(context).selectedCountryId =
                          address.countryId;
                      AuthCubit.get(context).selectedCityId = address.cityId;
                      AuthCubit.get(context).changeCountry(address.country);
                      AuthCubit.get(context).changeCity(address.city);
                      Navigation.push(
                          context,
                          AddAddressScreen(
                            isUpdate: true,
                            addressId: address.id,
                          ));
                    },
                    child: SvgPicture.asset(AppAssets.edit1, height: 17.h)),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              backgroundColor:
                                  AppColors.white.withValues(alpha: 0.65),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 4.0,
                                    sigmaY: 4.0,
                                  ),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16.h, horizontal: 24.w),
                                      //EdgeInsets.all(50.sp),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.white,
                                          width: 2.w,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Column(
                                          spacing: 8.h,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.error_outline_rounded,
                                              color: AppColors.red,
                                              size: 50.sp,
                                            ),
                                            TextBody14(
                                              'سيتم حذف العنوان \nهل انت متأكد؟',
                                              fontSize: 16.sp,
                                              color: AppColors.black,
                                              textAlign: TextAlign.center,
                                            ),
                                            BlocConsumer<AuthCubit, AuthState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteAddressSuccessState) {
                                                  AuthCubit.get(context)
                                                      .viewToast(
                                                          state.msg,
                                                          context,
                                                          AppColors.red,
                                                          3);
                                                  Navigator.pop(context);
                                                } else if (state
                                                    is DeleteAddressErrorState) {
                                                  AuthCubit.get(context)
                                                      .viewToast(
                                                          state.msg,
                                                          context,
                                                          AppColors.red,
                                                          4);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is DeleteAddressLoadingState) {
                                                  return Center(
                                                    child: LoadingAnimationWidget
                                                        .inkDrop(
                                                            color: AppColors
                                                                .primaryColor,
                                                            size: 15.sp),
                                                  );
                                                } else {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      CustomButton(
                                                        onPressed: () {
                                                          AuthCubit.get(context)
                                                              .deleteAddress(
                                                                  address.id ??
                                                                      0);
                                                        },
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              HexColor(
                                                                '#DA6A6A',
                                                              ),
                                                              HexColor(
                                                                '#B20707',
                                                              )
                                                            ]),
                                                        borderRadius: 8.r,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      4.h),
                                                          child: SizedBox(
                                                            width: 95.w,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextBody12(
                                                                  'حذف',
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                ),
                                                                SizedBox(
                                                                    width: 4.w),
                                                                SvgPicture
                                                                    .asset(
                                                                  AppAssets
                                                                      .delete,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      CustomButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        backgroundColor:
                                                            AppColors.white,
                                                        child: Container(
                                                          width: 95.w,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      4.h),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                              border: Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .red)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextBody12(
                                                                'إلغاء',
                                                                color: AppColors
                                                                    .red,
                                                              ),
                                                              SizedBox(
                                                                  width: 4.w),
                                                              Icon(
                                                                Icons
                                                                    .cancel_outlined,
                                                                color: AppColors
                                                                    .red,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                            ),
                                          ]))));
                        });
                  },
                  child: SvgPicture.asset(
                    AppAssets.delete,
                    colorFilter:
                        ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                    height: 22.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
