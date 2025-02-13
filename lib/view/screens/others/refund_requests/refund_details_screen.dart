import 'dart:ui';
import 'package:ecommerce/view/screens/brands_sceen/brands_screen.dart';
import 'package:ecommerce/view/screens/categories/components/favorite_component/favorite_component.dart';
import 'package:ecommerce/view/screens/categories/components/share_component/share_component.dart';
import 'package:ecommerce/view/screens/others/policies/refund_policy/refund_policy.dart';
import 'package:ecommerce/view_model/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../common_components/custom_button/custom_button.dart';
import '../../categories/components/counter_component/counter_component.dart';

class RefundDetailsScreen extends StatelessWidget {
  const RefundDetailsScreen({super.key, required this.fromCart});

  final bool fromCart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        //final cubit = ProductsCubit.get(context);

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  children: [
                    BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height / 2,
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 38.h, bottom: 70.h),
                          decoration: BoxDecoration(
                            color: AppColors.grey.withValues(alpha: 0.2),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(AppAssets.header),
                            ),
                          ),
                          child: Stack(children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            color: AppColors.black
                                                .withValues(alpha: 0.15),
                                            blurRadius: 10,
                                            offset: const Offset(0, 1),
                                          ),
                                        ], shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                          AppAssets.backIcon1,
                                          height: 24.h,
                                          width: 24.w,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    FavoriteComponent(productId: 1),
                                    SizedBox(width: 10.w),
                                    const ShareComponent(),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: HexColor('#EFEFEF')
                                              .withValues(alpha: 0.7),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.black
                                                  .withValues(alpha: 0.3),
                                              blurRadius: 10,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              5,
                                              (index) {
                                                final isSelected = index == 0;

                                                return InkWell(
                                                  onTap: () {},
                                                  child: Center(
                                                    child: Container(
                                                      width: 75.w,
                                                      // height: 50.h,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 4.h,
                                                        horizontal: 4.w,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        child: Stack(
                                                          children: [
                                                            Positioned.fill(
                                                                child:
                                                                    Image.asset(
                                                              AppAssets.header,
                                                              fit: BoxFit.cover,
                                                            )),
                                                            if (!isSelected)
                                                              Positioned.fill(
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .black
                                                                      .withValues(
                                                                          alpha:
                                                                              0.4),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            /*Image.asset(
                                  AppAssets.trailer,
                                  fit: BoxFit.cover,
                                ),*/
                            /*FutureBuilder(
                                  future: precacheImage(
                                    CachedNetworkImageProvider(
                                        cubit.peekStack() ?? cubit.imageUrl),
                                    context,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: LoadingAnimationWidget.inkDrop(
                                          color: AppColors.primaryColor,
                                          size: 30.sp,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                        child: Icon(Icons.error),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),*/
                          ]),
                        );
                      },
                    ),
                    SizedBox(
                      height: 410.h,
                    )
                  ],
                ),
                PositionedDirectional(
                  top: 285.h,
                  bottom: 0,
                  start: 0,
                  end: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        width: double.infinity,
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.r),
                            topRight: Radius.circular(32.r),
                          ),
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
                          children: [
                            Center(
                                child: TextTitle(
                              'طلب استرجاع للمنتج',
                              color: HexColor('#FD6868'),
                              fontSize: 20.sp,
                            )),
                            Row(
                              children: [
                                TextTitle(
                                  'هودي بسوستة',
                                  color: AppColors.primaryColor,
                                  fontSize: 18.sp,
                                ),
                                const Spacer(),
                                Row(
                                  children: List.generate(3, (index) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 4.w),
                                      child: SvgPicture.asset(AppAssets.star),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    TextBody14(
                                      '55 ر.س',
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                TextBody14('المقاس'),
                                SizedBox(width: 8.w),
                                Container(
                                    width: 65.w,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: TextBody12(
                                      'XXL',
                                    ))
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Center(
                              child: Container(
                                width: 40.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: AppColors.white,
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.15),
                                        offset: Offset(1.w, 3.h),
                                        blurRadius: 6.0,
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              spacing: 6.w,
                              children: [
                                TextBody14(
                                  'العدد المطلوب : ',
                                  color: AppColors.black,
                                ),
                                TextBody14('5 قطع'),
                                const Spacer(),
                                Column(
                                  children: [
                                    TextBody12('القطع المسترجعة'),
                                    SizedBox(height: 2.h),
                                    CounterComponent(
                                      productId: 1,
                                      cart: false,
                                      productCount: 1,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 6.w,
                              children: [
                                const TextBody14('العلامة التجارية:'),
                                GestureDetector(
                                  onTap: () {
                                    Navigation.push(context, BrandsScreen());
                                  },
                                  child: TextBody14(
                                    'LIL-ليل',
                                    color: HexColor('#0082C8'),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                TextBody14(
                                  'تاريخ الطلب: ',
                                  fontSize: 10.sp,
                                ),
                                TextBody14('10/12/2024', fontSize: 10.sp),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Visibility(
                              visible: fromCart,
                              replacement: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 60.h,
                                      width: 250.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(14.r),
                                          border: Border.all(
                                              color: AppColors.primaryColor),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primaryColor
                                                  .withValues(alpha: 0.4),
                                              offset: Offset(2.w, 3.h),
                                              blurRadius: 6.0,
                                            )
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextTitle(
                                            'حالة الطلب',
                                            color: AppColors.primaryColor,
                                          ),
                                          TextBody14(
                                            'قيد المراجعة',
                                            color: HexColor('#377AD2'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  TextTitle(
                                    'تفاصيل حالة الطلب',
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  TextBody14(
                                      textAlign: TextAlign.center,
                                      'طلبكم قيد المراجعه من قبل القائمين في قسم استرجاع المنتجات لدينا , عادتاً ما يتم الرد خلال 48 ساعة فترقبو الرد من خلال الاشعارات الواردة اليكم علي التطبيق او عن طريق البريد الالكتروني الخاص بكم .')
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      TextTitle(
                                        'سبب الاسترجاع؟',
                                        color: AppColors.primaryColor,
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigation.push(
                                              context, const RefundPolicy());
                                        },
                                        child: Container(
                                            width: 140.w,
                                            height: 40.h,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                                color: HexColor('#63C2B1'),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                border: Border.all(
                                                    color:
                                                        AppColors.primaryColor),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(
                                                            alpha: 0.15),
                                                    offset: Offset(1.w, 3.h),
                                                    blurRadius: 6.0,
                                                  ),
                                                ]),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextBody12(
                                                  'سياسة الاسترجاع!',
                                                  color: AppColors.white,
                                                ),
                                                SizedBox(width: 8.w),
                                                SvgPicture.asset(
                                                    AppAssets.lightBulb)
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  DropdownButtonFormField<String>(
                                    items: ['سبب 1', 'سبب 2', 'سبب 3']
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: TextBody12(
                                              item,
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor),
                                      ),
                                      fillColor: AppColors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                          right: 16.w, left: 16.w, bottom: 5.h),
                                      hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.black,
                                        fontFamily: 'Lamar',
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                    dropdownColor: AppColors.white,
                                    hint: TextBody12(
                                      'اختر سبب الاسترجاع',
                                      color: AppColors.black,
                                    ),
                                    iconSize: 0,
                                    icon: SvgPicture.asset(
                                      AppAssets.arrowDown,
                                      height: 10.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Center(
                                    child: TextTitle(
                                      'طريقة إرجاع النقود؟',
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                width: 24.w,
                                                height: 24.h,
                                                padding: EdgeInsets.all(3.sp),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 1.5.sp),
                                                  color: Colors.transparent,
                                                ),
                                                child: Container(
                                                  width: 12.w,
                                                  height: 12.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 1.sp),
                                                      color:
                                                          Colors.transparent),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            TextBody12('رصيد للمحفظة'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                width: 24.w,
                                                height: 24.h,
                                                padding: EdgeInsets.all(3.sp),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 1),
                                                  color: Colors.transparent,
                                                ),
                                                child: Container(
                                                  width: 12.w,
                                                  height: 12.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 1),
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topRight,
                                                          end: Alignment
                                                              .bottomLeft,
                                                          colors: [
                                                            HexColor('#29F3D1'),
                                                            HexColor('#177565'),
                                                          ])),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            TextBody12('نقدي'),
                                          ],
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Visibility(
                                visible: fromCart,
                                replacement: InkWell(
                                  borderRadius: BorderRadius.circular(14.r),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: AppColors.white
                                              .withValues(alpha: 0.65),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 6.0,
                                              sigmaY: 6.0,
                                            ),
                                            child: Container(
                                              width: 230.w,
                                              height: 180.h,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 24.h,
                                                  horizontal: 20.w),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.white,
                                                  width: 2.w,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.error_outline_rounded,
                                                    color: AppColors
                                                        .secondaryColor,
                                                    size: 60.sp,
                                                  ),
                                                  TextBody14(
                                                    'سيتم إلغاء طلب استرجاع \nالمنتج هل انت متأكد؟',
                                                    color: AppColors.black,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Row(
                                                    spacing: 8.w,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        child: CustomButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                            AuthCubit.get(
                                                                    context)
                                                                .viewToast(
                                                                    'تم إلغاء طلب الإسترجاع بنجاح',
                                                                    context,
                                                                    Colors
                                                                        .green);
                                                          },
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                HexColor(
                                                                  '#66B873',
                                                                ),
                                                                HexColor(
                                                                  '#0AB023',
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
                                                                    'تأكيد',
                                                                    color: AppColors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          4.w),
                                                                  SvgPicture
                                                                      .asset(
                                                                    AppAssets
                                                                        .right,
                                                                    colorFilter: ColorFilter.mode(
                                                                        AppColors
                                                                            .white,
                                                                        BlendMode
                                                                            .srcIn),
                                                                    height:
                                                                        14.h,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: CustomButton(
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
                                                                            8
                                                                                .r),
                                                                border: Border.all(
                                                                    color:
                                                                        AppColors
                                                                            .red,
                                                                    width: 1)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextBody12(
                                                                  'إلغاء',
                                                                  color:
                                                                      AppColors
                                                                          .red,
                                                                ),
                                                                SizedBox(
                                                                    width: 4.w),
                                                                Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                  color:
                                                                      AppColors
                                                                          .red,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        border: Border.all(
                                          color: AppColors.red,
                                          width: 1.5,
                                        ),
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.black
                                                .withValues(alpha: 0.15),
                                            offset: Offset(2.w, 3.h),
                                            blurRadius: 6.0,
                                          )
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextTitle(
                                          'إلغاء طلب الاسترجاع',
                                          color: AppColors.red,
                                        ),
                                        SizedBox(width: 6.w),
                                        SvgPicture.asset(
                                          AppAssets.cancel,
                                          height: 22.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14.r),
                                  onTap: () {
                                    debugPrint('Accept Request');
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: AppColors.white
                                              .withValues(alpha: 0.65),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 6.0,
                                              sigmaY: 6.0,
                                            ),
                                            child: Container(
                                              width: 230.w,
                                              height: 150.h,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16.h,
                                                  horizontal: 20.w),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.white,
                                                  width: 2.w,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SvgPicture.asset(
                                                    AppAssets.confirm,
                                                    height: 75.h,
                                                  ),
                                                  TextTitle(
                                                    'تم تأكيد الطلب',
                                                    color: AppColors.black,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });

                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.h,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 12.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            HexColor('#39FAD9'),
                                            HexColor('#03A186')
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.black
                                                .withValues(alpha: 0.15),
                                            offset: Offset(0.0, 3.h),
                                            blurRadius: 6.0,
                                          ),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 6.w,
                                      children: [
                                        TextTitle(
                                          'تأكيد الطلب',
                                          color: AppColors.white,
                                        ),
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 18.h,
                                          colorFilter: ColorFilter.mode(
                                              AppColors.white, BlendMode.srcIn),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: 60.h)
                          ],
                        ),
                      ),
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
