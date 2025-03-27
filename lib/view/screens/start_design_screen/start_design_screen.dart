import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/view/common_components/custom_button/custom_button.dart';
import 'package:ecommerce/view_model/cubits/start_design/start_design_cubit.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/utils/Texts/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../common_components/not_logged_component/not_logged_component.dart';
import 'components/check_box_component.dart';
import 'components/custom_header.dart';
import 'components/example_card.dart';
import 'components/progress_bar.dart';

class StartDesignScreen extends StatelessWidget {
  const StartDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(AppAssets.back).image,
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        controller: StartDesignCubit.get(context).scrollController,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: SharedHelper.getData(SharedKeys.platform) == 'ios'
                    ? 8.h
                    : 16.h),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset(AppAssets.createBackground).image,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  'صمم عبارتك بنفسك',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  gradient: LinearGradient(colors: [
                    HexColor('#09F1CA'),
                    HexColor('#03A186'),
                  ]),
                ),
                SizedBox(
                  height: 4.h,
                ),
                const TextBody14(
                    'يمكنك الآن تصميم منتجك بما\nيناسبك في عدة خطوات بسيطة.\nأنت الآن المصمم'),
                SizedBox(
                  height: 6.h,
                ),
                TextTitle(
                  'ابدأ تصميمك ...',
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.lamp,
                height: 22.h,
              ),
              SizedBox(
                width: 8.w,
              ),
              GradientText(
                'نوع عبارتك',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                gradient: AppColors.gradient,
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            spacing: 8.w,
            children: const [
              Expanded(
                child: CustomHeader(
                  title: 'أمثلة',
                  menuId: 1,
                  isModel: false,
                ),
              ),
              Expanded(
                child: CustomHeader(
                  title: 'أسماء',
                  menuId: 2,
                  isModel: false,
                ),
              ),
              Expanded(
                child: CustomHeader(
                  title: 'شعار',
                  menuId: 3,
                  isModel: false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 54.w),
            child: Row(
                spacing: 8.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: CustomHeader(
                      title: 'صورة',
                      menuId: 5,
                      isModel: false,
                    ),
                  ),
                  Expanded(
                    child: CustomHeader(
                      title: 'رقم',
                      menuId: 4,
                      isModel: false,
                    ),
                  ),
                ]),
          ),
          SizedBox(
            height: 12.h,
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              final cubit = StartDesignCubit.get(context);

              return GestureDetector(
                onTap: () {
                  cubit.changeStep(1);
                },
                child: Column(
                  children: [
                    if (cubit.isMenuOpen(1))
                      Container(
                        width: double.infinity,
                        height: 150.h,
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.w,
                            )),
                        child: BlocBuilder<StartDesignCubit, StartDesignState>(
                          builder: (context, state) {
                            if (state is GetExamplesLoadingState) {
                              return Center(
                                  child: LoadingAnimationWidget.inkDrop(
                                color: AppColors.primaryColor,
                                size: 30.sp,
                              ));
                            } else {
                              if (StartDesignCubit.get(context)
                                  .examples
                                  .isEmpty) {
                                return const Center(
                                  child: TextTitle('لا يوجد امثلة'),
                                );
                              }
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return ExampleCard(
                                    type: 'examples',
                                    checkId: StartDesignCubit.get(context)
                                        .examples[index]
                                        .id!,
                                    image: StartDesignCubit.get(context)
                                        .examples[index]
                                        .media!,
                                    currentStep: 1,
                                    price: StartDesignCubit.get(context)
                                        .examples[index]
                                        .price!,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 8.w);
                                },
                                itemCount: StartDesignCubit.get(context)
                                    .examples
                                    .length,
                              );
                            }
                          },
                        ),
                      ),
                    if (cubit.isMenuOpen(2))
                      Container(
                        width: double.infinity,
                        height: 150.h,
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.w,
                            )),
                        child: BlocBuilder<StartDesignCubit, StartDesignState>(
                          builder: (context, state) {
                            if (state is GetExamplesLoadingState) {
                              return Center(
                                  child: LoadingAnimationWidget.inkDrop(
                                color: AppColors.primaryColor,
                                size: 30.sp,
                              ));
                            } else {
                              if (StartDesignCubit.get(context)
                                  .examples
                                  .isEmpty) {
                                return const Center(
                                  child: TextTitle('لا يوجد أسماء'),
                                );
                              }
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return ExampleCard(
                                    type: 'names',
                                    checkId: StartDesignCubit.get(context)
                                        .names[index]
                                        .id!,
                                    image: StartDesignCubit.get(context)
                                        .names[index]
                                        .media!,
                                    currentStep: 1,
                                    price: StartDesignCubit.get(context)
                                        .names[index]
                                        .price!,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 8.w);
                                },
                                itemCount:
                                    StartDesignCubit.get(context).names.length,
                              );
                            }
                          },
                        ),
                      ),
                    if (cubit.isMenuOpen(3))
                      Container(
                        width: double.infinity,
                        height: 150.h,
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.w,
                            )),
                        child: BlocBuilder<StartDesignCubit, StartDesignState>(
                          builder: (context, state) {
                            if (state is GetExamplesLoadingState) {
                              return Center(
                                  child: LoadingAnimationWidget.inkDrop(
                                color: AppColors.primaryColor,
                                size: 30.sp,
                              ));
                            } else {
                              if (StartDesignCubit.get(context)
                                  .examples
                                  .isEmpty) {
                                return const Center(
                                  child: TextTitle('لا يوجد شعارات'),
                                );
                              }
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return ExampleCard(
                                    type: 'logos',
                                    checkId: StartDesignCubit.get(context)
                                        .logos[index]
                                        .id!,
                                    image: StartDesignCubit.get(context)
                                        .logos[index]
                                        .image!,
                                    currentStep: 1,
                                    price: StartDesignCubit.get(context)
                                        .logos[index]
                                        .price!,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 8.w);
                                },
                                itemCount:
                                    StartDesignCubit.get(context).logos.length,
                              );
                            }
                          },
                        ),
                      ),
                    if (cubit.isMenuOpen(4))
                      _buildMenuContainer(false, 4, context),
                    if (cubit.isMenuOpen(5))
                      Container(
                        width: double.infinity,
                        height: 150.h,
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.w,
                            )),
                        child: BlocBuilder<StartDesignCubit, StartDesignState>(
                          builder: (context, state) {
                            if (state is GetExamplesLoadingState) {
                              return Center(
                                  child: LoadingAnimationWidget.inkDrop(
                                color: AppColors.primaryColor,
                                size: 30.sp,
                              ));
                            } else {
                              if (StartDesignCubit.get(context)
                                  .examples
                                  .isEmpty) {
                                return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      ExampleCard(
                                        price: 40,
                                        type: 'images',
                                        checkId: 100,
                                        image: AppAssets.uploadImage,
                                        currentStep: 1,
                                      ),
                                    ]);
                              }
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index !=
                                      StartDesignCubit.get(context)
                                          .images
                                          .length) {
                                    return ExampleCard(
                                      type: 'images',
                                      checkId: StartDesignCubit.get(context)
                                          .images[index]
                                          .id!,
                                      image: StartDesignCubit.get(context)
                                          .images[index]
                                          .image!,
                                      currentStep: 1,
                                      price: StartDesignCubit.get(context)
                                          .images[index]
                                          .price!,
                                    );
                                  } else {
                                    return ExampleCard(
                                      price: 40,
                                      type: 'images',
                                      checkId: 100,
                                      image: AppAssets.uploadImage,
                                      currentStep: 1,
                                    );
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 8.w);
                                },
                                itemCount: StartDesignCubit.get(context)
                                        .images
                                        .length +
                                    1,
                              );
                            }
                          },
                        ),
                      )
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 12.h,
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              return Visibility(
                visible: StartDesignCubit.get(context).currentStep == 1,
                child: Column(
                  children: [
                    BlocBuilder<StartDesignCubit, StartDesignState>(
                      builder: (context, state) {
                        return ProgressBar(
                            currentStep:
                                StartDesignCubit.get(context).currentStep);
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      borderRadius: 10.r,
                      onPressed: () {
                        if (StartDesignCubit.get(context)
                                .examplesChecked
                                .isNotEmpty ||
                            StartDesignCubit.get(context)
                                .namesChecked
                                .isNotEmpty ||
                            StartDesignCubit.get(context)
                                .logosChecked
                                .isNotEmpty ||
                            StartDesignCubit.get(context)
                                .imagesChecked
                                .isNotEmpty ||
                            StartDesignCubit.get(context)
                                .numberController
                                .text
                                .isNotEmpty) {
                          StartDesignCubit.get(context).changeStep(
                              StartDesignCubit.get(context).currentStep + 1);
                          StartDesignCubit.get(context).getPrintTypes();
                        } else {
                          StartDesignCubit.get(context).viewToast(
                              'يرجى تحديد نوع عبارتك', context, Colors.red);
                        }
                      },
                      child: Container(
                        width: 100.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          gradient: LinearGradient(colors: [
                            HexColor('#31D3C6'),
                            HexColor('#208B78'),
                          ]),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.w,
                          children: [
                            TextTitle(
                              'التالي',
                              color: AppColors.white,
                            ),
                            Transform.rotate(
                                angle: 3.141592653589793 / 360 * -180,
                                child: SvgPicture.asset(AppAssets.scissors2))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              return Visibility(
                visible: StartDesignCubit.get(context).currentStep >= 2,
                child: Column(children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.print,
                        height: 22.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      GradientText(
                        'نوع الطباعة',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        gradient: AppColors.gradient,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      StartDesignCubit.get(context).changeStep(2);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.w,
                        ),
                      ),
                      child: BlocConsumer<StartDesignCubit, StartDesignState>(
                        listener: (context, state) {
                          if (state is GetPrintTypesErrorState) {
                            StartDesignCubit.get(context)
                                .viewToast('حدث خطأ', context, Colors.red);
                          }
                        },
                        builder: (context, state) {
                          if (state is GetPrintTypesLoadingState) {
                            return Center(
                                child: LoadingAnimationWidget.inkDrop(
                              color: AppColors.primaryColor,
                              size: 15.sp,
                            ));
                          } else {
                            return Wrap(
                              spacing: 16.w,
                              runSpacing: 4.h,
                              children: List.generate(
                                  StartDesignCubit.get(context)
                                      .printTypes
                                      .length, (index) {
                                var options =
                                    StartDesignCubit.get(context).printTypes;
                                return SizedBox(
                                  width: 90.w,
                                  child: CheckBoxComponent(
                                    printId: options[index].id!,
                                    title: options[index].nameAr!,
                                    price: options[index].price!,
                                    currentStep: 2,
                                  ),
                                );
                              }),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  BlocBuilder<StartDesignCubit, StartDesignState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: StartDesignCubit.get(context).currentStep == 2,
                        child: Column(
                          children: [
                            ProgressBar(
                                currentStep:
                                    StartDesignCubit.get(context).currentStep),
                            SizedBox(
                              height: 12.h,
                            ),
                            CustomButton(
                              borderRadius: 10.r,
                              onPressed: () {
                                if (StartDesignCubit.get(context)
                                    .printChecked
                                    .isNotEmpty) {
                                  StartDesignCubit.get(context).changeStep(
                                      StartDesignCubit.get(context)
                                              .currentStep +
                                          1);
                                  StartDesignCubit.get(context)
                                      .getSizesAndDirections();
                                } else {
                                  StartDesignCubit.get(context).viewToast(
                                      'يرجى تحديد نوع الطباعة',
                                      context,
                                      Colors.red);
                                }
                              },
                              child: Container(
                                width: 100.w,
                                height: 34.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  gradient: LinearGradient(colors: [
                                    HexColor('#31D3C6'),
                                    HexColor('#208B78'),
                                  ]),
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.grey,
                                      blurRadius: 5,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 8.w,
                                  children: [
                                    TextTitle(
                                      'التالي',
                                      color: AppColors.white,
                                    ),
                                    Transform.rotate(
                                        angle: 3.141592653589793 / 360 * -180,
                                        child: SvgPicture.asset(
                                            AppAssets.scissors2))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]),
              );
            },
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
              builder: (context, state) {
            final cubit = StartDesignCubit.get(context);
            return Visibility(
              visible: cubit.currentStep >= 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.sizes,
                        height: 22.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      GradientText(
                        'مقاسات واتجاهات الطباعة',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        gradient: AppColors.gradient,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      StartDesignCubit.get(context).changeStep(3);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.w,
                        ),
                      ),
                      child: BlocConsumer<StartDesignCubit, StartDesignState>(
                        listener: (context, state) {
                          if (state is GetSizesAndDirectionsErrorState) {
                            StartDesignCubit.get(context)
                                .viewToast('حدث خطأ', context, Colors.red);
                          }
                        },
                        builder: (context, state) {
                          if (state is GetSizesAndDirectionsLoadingState) {
                            return Center(
                                child: LoadingAnimationWidget.inkDrop(
                              color: AppColors.primaryColor,
                              size: 15.sp,
                            ));
                          } else {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                ),
                                child: Wrap(
                                    spacing: 16.w,
                                    runSpacing: 4.h,
                                    children: List.generate(
                                        cubit.sizesAndDirections.length,
                                        (index) {
                                      final options = cubit.sizesAndDirections;
                                      return SizedBox(
                                        width: 90.w,
                                        child: CheckBoxComponent(
                                          printId: options[index].id!,
                                          title: options[index].nameAr!,
                                          price: options[index].price!,
                                          currentStep: 3,
                                        ),
                                      );
                                    }))

                                /* GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.8,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cubit.sizesAndDirections.length,
                                itemBuilder: (context, index) {
                                  final options = cubit.sizesAndDirections;
                                  return CheckBoxComponent(
                                    printId: options[index].id!,
                                    title: options[index].nameAr!,
                                    price: options[index].price!,
                                    currentStep: 3,
                                  );
                                },
                              ),*/
                                );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: 12.h,
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              return Visibility(
                visible: StartDesignCubit.get(context).currentStep == 3,
                child: Column(
                  children: [
                    ProgressBar(
                        currentStep: StartDesignCubit.get(context).currentStep),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      borderRadius: 10.r,
                      onPressed: () {
                        if (StartDesignCubit.get(context)
                            .multiChecked
                            .isNotEmpty) {
                          StartDesignCubit.get(context).changeStep(
                              StartDesignCubit.get(context).currentStep + 1);
                        } else {
                          StartDesignCubit.get(context).viewToast(
                              'يرجى تحديد مقاس واتجاه الطباعة',
                              context,
                              Colors.red);
                        }
                        Future.delayed(const Duration(milliseconds: 15), () {
                          StartDesignCubit.get(context).scrollToBottom();
                        });
                      },
                      child: Container(
                        width: 100.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          gradient: LinearGradient(colors: [
                            HexColor('#31D3C6'),
                            HexColor('#208B78'),
                          ]),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.w,
                          children: [
                            TextTitle(
                              'التالي',
                              color: AppColors.white,
                            ),
                            Transform.rotate(
                                angle: 3.141592653589793 / 360 * -180,
                                child: SvgPicture.asset(AppAssets.scissors2))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
              builder: (context, state) {
            final cubit = StartDesignCubit.get(context);
            return Visibility(
              visible: cubit.currentStep >= 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.color,
                        height: 22.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      GradientText(
                        'لون الطباعة',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        gradient: AppColors.gradient,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  const Center(child: TextBody14('اختر لون طباعتك')),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.changeStep(4);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: AppColors.white,
                            title: const TextTitle(
                              'اختر لونًا!',
                            ),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                hexInputBar: true,
                                enableAlpha: false,
                                hexInputController: cubit.colorController,
                                pickerColor: cubit.selectedColor,
                                // Initial color from Cubit
                                onColorChanged: (color) {
                                  cubit.changeColor(
                                      color); // Update color in the Cubit
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: TextTitle(
                                  'تم',
                                  color: AppColors.black,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  debugPrint('#${cubit.colorController.text}');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            image: Image.asset(
                              AppAssets.colorPick,
                            ).image,
                          )),
                    ),
                  ),
                  Center(
                      child: Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cubit.selectedColor,
                    ),
                  )),
                ],
              ),
            );
          }),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              return Visibility(
                visible: StartDesignCubit.get(context).currentStep == 4,
                child: Column(
                  children: [
                    ProgressBar(
                        currentStep: StartDesignCubit.get(context).currentStep),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      borderRadius: 10.r,
                      onPressed: () {
                        StartDesignCubit.get(context).changeStep(
                            StartDesignCubit.get(context).currentStep + 1);
                        StartDesignCubit.get(context).getMaterials();
                      },
                      child: Container(
                        width: 100.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          gradient: LinearGradient(colors: [
                            HexColor('#31D3C6'),
                            HexColor('#208B78'),
                          ]),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.w,
                          children: [
                            TextTitle(
                              'التالي',
                              color: AppColors.white,
                            ),
                            Transform.rotate(
                                angle: 3.141592653589793 / 360 * -180,
                                child: SvgPicture.asset(AppAssets.scissors2))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
              builder: (context, state) {
            final cubit = StartDesignCubit.get(context);
            return Visibility(
              visible: cubit.currentStep >= 5,
              child: Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.material,
                        height: 22.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      GradientText(
                        'نوع الخامة',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        gradient: AppColors.gradient,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      StartDesignCubit.get(context).changeStep(5);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.w,
                        ),
                      ),
                      child: BlocBuilder<StartDesignCubit, StartDesignState>(
                        builder: (context, state) {
                          if (state is GetMaterialLoadingState) {
                            return Center(
                              child: LoadingAnimationWidget.inkDrop(
                                  color: AppColors.primaryColor, size: 15.sp),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, bottom: 4.h),
                              child: Wrap(
                                spacing: 16.w,
                                // Increase spacing for better symmetry
                                runSpacing: 4.h,
                                alignment: WrapAlignment.spaceBetween,
                                children: List.generate(
                                  cubit.materials.length,
                                  (index) {
                                    final options = cubit.materials;
                                    return SizedBox(
                                      width: 90.w,
                                      child: CheckBoxComponent(
                                        printId: options[index].id!,
                                        title: options[index].nameAr!,
                                        price: options[index].price!,
                                        currentStep: 5,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              return Visibility(
                visible: StartDesignCubit.get(context).currentStep == 5,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    ProgressBar(
                        currentStep: StartDesignCubit.get(context).currentStep),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      borderRadius: 10.r,
                      onPressed: () {
                        if (StartDesignCubit.get(context)
                            .materialChecked
                            .isNotEmpty) {
                          StartDesignCubit.get(context).changeStep(
                              StartDesignCubit.get(context).currentStep + 1);
                          StartDesignCubit.get(context).getModels();
                        } else {
                          StartDesignCubit.get(context).viewToast(
                              'يرجى تحديد نوع الخامة', context, Colors.red);
                        }
                      },
                      child: Container(
                        width: 100.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          gradient: LinearGradient(colors: [
                            HexColor('#31D3C6'),
                            HexColor('#208B78'),
                          ]),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.w,
                          children: [
                            TextTitle(
                              'التالي',
                              color: AppColors.white,
                            ),
                            Transform.rotate(
                                angle: 3.141592653589793 / 360 * -180,
                                child: SvgPicture.asset(AppAssets.scissors2))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
              builder: (context, state) {
            final cubit = StartDesignCubit.get(context);
            return Visibility(
              visible: cubit.currentStep >= 6,
              child: Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.model,
                        height: 22.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      GradientText(
                        'نوع الموديل',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        gradient: AppColors.gradient,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      StartDesignCubit.get(context).changeStep(6);
                    },
                    child: BlocBuilder<StartDesignCubit, StartDesignState>(
                      builder: (context, state) {
                        if (state is GetModelLoadingState) {
                          return Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: AppColors.primaryColor, size: 15.sp),
                          );
                        } else {
                          return Wrap(
                            spacing: 16.w,
                            runSpacing: 8.h,
                            alignment: WrapAlignment.spaceBetween,
                            children: List.generate(
                              cubit.models.length,
                              (index) {
                                final options = cubit.models;
                                return SizedBox(
                                  width: 90.w,
                                  height: 26.h,
                                  child: CustomHeader(
                                      title: options[index].nameAr!,
                                      menuId: options[index].id!,
                                      isModel: true),
                                );
                              },
                            ),
                          );
                          /* GridView.builder(
                            padding: EdgeInsets.all(12.sp),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 25.h,
                              crossAxisSpacing: 8.w,
                              mainAxisSpacing: 8.h,
                              childAspectRatio: 2.2,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.models.length,
                            itemBuilder: (context, index) {
                              final options = cubit.models;
                              return CustomHeader(
                                  title: options[index].nameAr!,
                                  menuId: options[index].id!,
                                  isModel: true);
                            },
                          );*/
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              final cubit = StartDesignCubit.get(context);

              return Visibility(
                visible: cubit.currentStep >= 6,
                child: GestureDetector(
                  onTap: () {
                    cubit.changeStep(1);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Container(
                          width: double.infinity,
                          height: 150.h,
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.w,
                            ),
                          ),
                          child:
                              BlocBuilder<StartDesignCubit, StartDesignState>(
                            builder: (context, state) {
                              debugPrint('Current state: $state');

                              if (state is GetProductLoadingState) {
                                return Center(
                                  child: LoadingAnimationWidget.inkDrop(
                                    color: AppColors.primaryColor,
                                    size: 15.sp,
                                  ),
                                );
                              }

                              if (StartDesignCubit.get(context)
                                  .products
                                  .isEmpty) {
                                return const Center(
                                  child: TextTitle('لا يوجد منتجات'),
                                );
                              }

                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: StartDesignCubit.get(context)
                                    .products
                                    .length,
                                itemBuilder: (context, index) {
                                  return ExampleCard(
                                    name: StartDesignCubit.get(context)
                                        .products[index]
                                        .name,
                                    checkId: StartDesignCubit.get(context)
                                        .products[index]
                                        .id!,
                                    image: StartDesignCubit.get(context)
                                        .products[index]
                                        .colors![0]
                                        .images![0]
                                        .url!,
                                    currentStep: 6,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 8.w),
                              );
                            },
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              return Visibility(
                visible: StartDesignCubit.get(context).currentStep == 6,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    ProgressBar(
                        currentStep: StartDesignCubit.get(context).currentStep),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      borderRadius: 10.r,
                      onPressed: () {
                        if (StartDesignCubit.get(context)
                            .modelChecked
                            .isNotEmpty) {
                          StartDesignCubit.get(context).changeStep(
                              StartDesignCubit.get(context).currentStep + 1);
                        } else {
                          StartDesignCubit.get(context).viewToast(
                              'يرجى تحديد المنتج', context, Colors.red);
                        }
                        Future.delayed(const Duration(milliseconds: 15), () {
                          StartDesignCubit.get(context).scrollToBottom();
                        });
                      },
                      child: Container(
                        width: 100.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          gradient: LinearGradient(colors: [
                            HexColor('#31D3C6'),
                            HexColor('#208B78'),
                          ]),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.w,
                          children: [
                            TextTitle(
                              'التالي',
                              color: AppColors.white,
                            ),
                            Transform.rotate(
                                angle: 3.141592653589793 / 360 * -180,
                                child: SvgPicture.asset(AppAssets.scissors2))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
              builder: (context, state) {
            final cubit = StartDesignCubit.get(context);
            return Visibility(
              visible: cubit.currentStep >= 7,
              child: Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.size,
                        height: 22.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      GradientText(
                        'مقاس ولون المنتج',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        gradient: AppColors.gradient,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (StartDesignCubit.get(context).currentStep != 7) {
                        StartDesignCubit.get(context).changeStep(7);
                        StartDesignCubit.get(context).scrollToPosition(1450);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.w,
                        ),
                      ),
                      child: BlocBuilder<StartDesignCubit, StartDesignState>(
                        builder: (context, state) {
                          final cubit = StartDesignCubit.get(context);
                          return Wrap(
                            spacing: 16.w,
                            runSpacing: 8.h,
                            alignment: WrapAlignment.spaceAround,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: List.generate(
                              cubit.sizes.length,
                              (index) {
                                return CheckBoxComponent(
                                  title: cubit.sizes[index].sizeCode!,
                                  printId: cubit.sizes[index].id!,
                                  currentStep: 7,
                                  price: cubit.sizes[index].discountPrice! == 0
                                      ? cubit.sizes[index].basicPrice!
                                      : cubit.sizes[index].discountPrice!,
                                );
                              },
                            ),
                          );
                          /*GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.2,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.sizes.length,
                            itemBuilder: (context, index) {
                              return CheckBoxComponent(
                                title: cubit.sizes[index].sizeCode!,
                                printId: cubit.sizes[index].id!,
                                currentStep: 7,
                                price: cubit.sizes[index].discountRate! == '0'
                                    ? cubit.sizes[index].basicPrice!
                                    : cubit.sizes[index].discountPrice!,
                              );
                            },
                          );*/
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8.w,
                    children: List.generate(
                      cubit.colors.length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            if (StartDesignCubit.get(context).currentStep !=
                                7) {
                              StartDesignCubit.get(context).changeStep(7);
                              StartDesignCubit.get(context)
                                  .changeColorCheck(cubit.colors[index].id!);
                              StartDesignCubit.get(context)
                                  .scrollToPosition(1500);
                            }
                            StartDesignCubit.get(context)
                                .changeColorCheck(cubit.colors[index].id!);
                          },
                          child: Center(
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HexColor(
                                      '${cubit.colors[index].colorCode}'),
                                  boxShadow: [
                                    cubit.isColorChecked(
                                            cubit.colors[index].id!)
                                        ? BoxShadow(
                                            color: AppColors.primaryColor,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          )
                                        : const BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                  ],
                                  border: Border.all(
                                    color: cubit.isColorChecked(
                                            cubit.colors[index].id!)
                                        ? AppColors.primaryColor
                                        : AppColors.grey,
                                    width: 1.sp,
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            builder: (context, state) {
              return Visibility(
                visible: StartDesignCubit.get(context).currentStep >= 7,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    ProgressBar(
                        currentStep: StartDesignCubit.get(context).currentStep),
                    SizedBox(
                      height: 12.h,
                    ),
                    Visibility(
                      visible: StartDesignCubit.get(context).currentStep == 7,
                      child: CustomButton(
                        borderRadius: 10.r,
                        onPressed: () {
                          if (StartDesignCubit.get(context)
                                  .sizeChecked
                                  .isNotEmpty &&
                              StartDesignCubit.get(context)
                                  .designColor
                                  .isNotEmpty) {
                            StartDesignCubit.get(context).changeStep(
                                StartDesignCubit.get(context).currentStep + 1);
                          } else {
                            StartDesignCubit.get(context).viewToast(
                                'يرجى تحديد مقاس ولون المنتج',
                                context,
                                Colors.red);
                          }
                          Future.delayed(const Duration(milliseconds: 15), () {
                            StartDesignCubit.get(context).scrollToBottom();
                          });
                        },
                        child: Container(
                          width: 100.w,
                          height: 34.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            gradient: LinearGradient(colors: [
                              HexColor('#31D3C6'),
                              HexColor('#208B78'),
                            ]),
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8.w,
                            children: [
                              TextTitle(
                                'التالي',
                                color: AppColors.white,
                              ),
                              Transform.rotate(
                                  angle: 3.141592653589793 / 360 * -180,
                                  child: SvgPicture.asset(AppAssets.scissors2))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<StartDesignCubit, StartDesignState>(
            buildWhen: (previous, current) =>
                current is! AddCartItemLoadingState,
            builder: (context, state) {
              final cubit = StartDesignCubit.get(context);
              return Visibility(
                visible: cubit.currentStep > 7,
                child: Column(
                  spacing: 12.h,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.review,
                          height: 22.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        TextTitle(
                          'مراجعة الطلب',
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        color: HexColor('#E6E6E6'),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.lamp,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                          height: 16.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody14(
                                          'نوع عبارتك',
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody12(
                                          cubit.examplesChecked.isNotEmpty
                                              ? 'أمثلة'
                                              : cubit.namesChecked.isNotEmpty
                                                  ? 'أسماء'
                                                  : cubit.logosChecked
                                                          .isNotEmpty
                                                      ? 'شعارات'
                                                      : cubit.imagesChecked
                                                              .isNotEmpty
                                                          ? 'صور'
                                                          : 'رقم',
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    cubit.numberController.text.isNotEmpty
                                        ? Container(
                                            width: 90.w,
                                            height: 110.h,
                                            padding: EdgeInsets.all(4.sp),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                color: AppColors.white),
                                            child: Center(
                                                child: TextBody14(
                                              cubit.numberController.text,
                                              fontSize: 18.sp,
                                              textAlign: TextAlign.center,
                                            )),
                                          )
                                        : cubit.selectedImage != null
                                            ? Container(
                                                width: 90.w,
                                                height: 110.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.file(
                                                        cubit.selectedImage!,
                                                      ).image,
                                                    )),
                                              )
                                            : Container(
                                                width: 90.w,
                                                height: 110.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      cubit.getCheckedMedia() ??
                                                          '',
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                ),
                                              ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.print,
                                          height: 16.h,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody14(
                                          'نوع الطباعة',
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody12(
                                          cubit.getCheckedPrint() ?? '',
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.sizes,
                                          height: 16.h,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody14(
                                          'مقاسات واتجاهات الطباعة',
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 4.h,
                                      children: List.generate(
                                        cubit.getCheckedSizeDirections().length,
                                        (index) => Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppAssets.right,
                                              height: 14.h,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            TextBody12(
                                              cubit.getCheckedSizeDirections()[
                                                  index],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.size,
                                          height: 16.h,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody14(
                                          'مقاس ولون المنتج',
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody12(
                                          '${cubit.getCheckedSize()}',
                                        ),
                                        SizedBox(width: 32.w),
                                        Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                              color: HexColor(
                                                  '${cubit.getCheckedColor()}'),
                                              shape: BoxShape.circle),
                                        )
                                      ],
                                    ),
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.model,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                          height: 16.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody14(
                                          'نوع الموديل',
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody12(
                                          cubit.getCheckedModel() ?? '',
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Container(
                                      width: 90.w,
                                      height: 110.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  cubit.getSelectedProductImage() ??
                                                      ''))),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.color,
                                          height: 16.h,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody14(
                                          'لون الطباعة',
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Center(
                                            child: Container(
                                          width: 30.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: StartDesignCubit.get(context)
                                                .selectedColor,
                                          ),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.material,
                                          height: 16.h,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody14(
                                          'نوع الخامة',
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        TextBody12(
                                          cubit.getMaterialName() ?? '',
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                          Divider(
                            color: AppColors.white,
                            thickness: 1.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 6.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextTitle(
                                  'إجمالي سعر الطلب',
                                  color: AppColors.primaryColor,
                                  fontSize: 15.sp,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                TextTitle(
                                  '${cubit.getTotalPrice()} ر.س',
                                  fontSize: 15.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    BlocConsumer<StartDesignCubit, StartDesignState>(
                      listener: (context, state) {
                        if (state is AddCartItemSuccessState) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => Dialog(
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
                                      vertical: 50.h, horizontal: 40.w),
                                  //EdgeInsets.all(50.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.confirm,
                                        height: 80.h,
                                        width: 80.w,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.green, BlendMode.srcIn),
                                      ),
                                      SizedBox(height: 24.h),
                                      TextTitle(
                                        'تم إضافة طلبك إلى العربة بنجاح',
                                        fontSize: 18.sp,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          Future.delayed(const Duration(seconds: 2))
                              .then((value) {
                            StartDesignCubit.get(context).changeStep(1);
                            StartDesignCubit.get(context).openMenu(1);
                            StartDesignCubit.get(context).scrollToTop();
                            StartDesignCubit.get(context).clear();
                            Navigator.pop(context);
                          });
                        }
                        if (state is AddCartItemErrorState) {
                          StartDesignCubit.get(context)
                              .viewToast(state.error, context, AppColors.red);
                        }
                      },
                      builder: (context, state) {
                        final cubit = StartDesignCubit.get(context);
                        if (state is AddCartItemLoadingState) {
                          return Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: AppColors.primaryColor, size: 20.sp),
                          );
                        } else {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 12.w,
                              children: [
                                CustomButton(
                                  borderRadius: 10.r,
                                  onPressed: () {
                                    StartDesignCubit.get(context).changeStep(7);
                                    StartDesignCubit.get(context)
                                        .scrollToPosition(1030.h);
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 34.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.grey,
                                          blurRadius: 5,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 8.w,
                                      children: [
                                        TextTitle(
                                          'تعديل',
                                          color: AppColors.primaryColor,
                                        ),
                                        Transform.rotate(
                                            angle:
                                                3.141592653589793 / 360 * 180,
                                            child: SvgPicture.asset(
                                              AppAssets.scissors2,
                                              colorFilter: ColorFilter.mode(
                                                AppColors.primaryColor,
                                                BlendMode.srcIn,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  borderRadius: 10.r,
                                  onPressed: () {
                                    if (SharedHelper.getData(
                                            SharedKeys.token) !=
                                        null) {
                                      cubit.addCartItem();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return const NotLoggedComponent();
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 34.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      gradient: LinearGradient(colors: [
                                        HexColor('#31D3C6'),
                                        HexColor('#208B78'),
                                      ]),
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.grey,
                                          blurRadius: 5,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 8.w,
                                      children: [
                                        TextTitle(
                                          'تأكيد',
                                          color: AppColors.white,
                                        ),
                                        SvgPicture.asset(
                                          AppAssets.right,
                                          height: 16.h,
                                          colorFilter: ColorFilter.mode(
                                              AppColors.white, BlendMode.srcIn),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
              height: SharedHelper.getData(SharedKeys.platform) == 'ios'
                  ? 50.h
                  : 65.h),
        ],
      ),
    );
  }
}

Widget _buildMenuContainer(bool isModel, int menuId, BuildContext context) {
  final locale = context.locale;
  final isRTL = locale.languageCode == 'ar';
  if (!isModel) {
    return (menuId != 4)
        ? Container(
            width: double.infinity,
            height: 150.h,
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.w,
                )),
            child: menuId == 1 &&
                    StartDesignCubit.get(context).examples.isNotEmpty
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ExampleCard(
                        type: 'examples',
                        checkId:
                            StartDesignCubit.get(context).examples[index].id!,
                        image: StartDesignCubit.get(context)
                            .examples[index]
                            .media!,
                        currentStep: 1,
                        price: StartDesignCubit.get(context)
                            .examples[index]
                            .price!,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 8.w);
                    },
                    itemCount: StartDesignCubit.get(context).examples.length,
                  )
                : menuId == 2 && StartDesignCubit.get(context).names.isNotEmpty
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return ExampleCard(
                            type: 'names',
                            checkId:
                                StartDesignCubit.get(context).names[index].id!,
                            image: StartDesignCubit.get(context)
                                .names[index]
                                .media!,
                            currentStep: 1,
                            price: StartDesignCubit.get(context)
                                .names[index]
                                .price!,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 8.w);
                        },
                        itemCount: StartDesignCubit.get(context).names.length,
                      )
                    : menuId == 3 &&
                            StartDesignCubit.get(context).logos.isNotEmpty
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return ExampleCard(
                                type: 'logos',
                                checkId: StartDesignCubit.get(context)
                                    .logos[index]
                                    .id!,
                                image: StartDesignCubit.get(context)
                                    .logos[index]
                                    .image!,
                                currentStep: 1,
                                price: StartDesignCubit.get(context)
                                    .logos[index]
                                    .price!,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: 8.w);
                            },
                            itemCount:
                                StartDesignCubit.get(context).logos.length,
                          )
                        : menuId == 5 &&
                                StartDesignCubit.get(context).images.isNotEmpty
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index !=
                                      StartDesignCubit.get(context)
                                          .images
                                          .length) {
                                    return ExampleCard(
                                      type: 'images',
                                      checkId: StartDesignCubit.get(context)
                                          .images[index]
                                          .id!,
                                      image: StartDesignCubit.get(context)
                                          .images[index]
                                          .image!,
                                      currentStep: 1,
                                      price: StartDesignCubit.get(context)
                                          .images[index]
                                          .price!,
                                    );
                                  } else {
                                    return ExampleCard(
                                      price: 40,
                                      type: 'images',
                                      checkId: 100,
                                      image: AppAssets.uploadImage,
                                      currentStep: 1,
                                    );
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 8.w);
                                },
                                itemCount: StartDesignCubit.get(context)
                                        .images
                                        .length +
                                    1,
                              )
                            : StartDesignCubit.get(context).examples.isEmpty ||
                                    StartDesignCubit.get(context)
                                        .names
                                        .isEmpty ||
                                    StartDesignCubit.get(context)
                                        .logos
                                        .isEmpty ||
                                    StartDesignCubit.get(context).images.isEmpty
                                ? Center(
                                    child: TextTitle(
                                      'لا يوجد اختيارات',
                                      fontSize: 14.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : null,
          )
        : TextFormField(
            textInputAction: TextInputAction.done,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            cursorColor: AppColors.primaryColor,
            keyboardType: TextInputType.number,
            onTap: () {
              StartDesignCubit.get(context).examplesChecked.clear();
              StartDesignCubit.get(context).namesChecked.clear();
              StartDesignCubit.get(context).logosChecked.clear();
              StartDesignCubit.get(context).imagesChecked.clear();
              StartDesignCubit.get(context).selectedImage = null;
              StartDesignCubit.get(context).changeStep(1);
            },
            textAlign: isRTL ? TextAlign.right : TextAlign.left,
            controller: StartDesignCubit.get(context).numberController,
            decoration: InputDecoration(
              hintText: 'أدخل رقم',
              hintStyle: TextStyle(
                fontSize: 10.sp,
                color: AppColors.grey,
                fontFamily: 'Lamar',
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              fillColor: AppColors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.primaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.primaryColor)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.primaryColor)),
            ),
          );
  } else {
    return Container(
        width: double.infinity,
        height: 150.h,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 1.w,
            )),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return ExampleCard(
              name: StartDesignCubit.get(context).products[index].name,
              checkId: StartDesignCubit.get(context).products[index].id!,
              image: StartDesignCubit.get(context)
                  .products[index]
                  .colors![0]
                  .images![0]
                  .url!,
              currentStep: 6,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 8.w);
          },
          itemCount: StartDesignCubit.get(context).products.length,
        ));
  }
}
