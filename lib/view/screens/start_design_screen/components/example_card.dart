import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/view_model/cubits/start_design/start_design_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../view_model/utils/Texts/Texts.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class ExampleCard extends StatelessWidget {
  const ExampleCard({
    super.key,
    required this.checkId,
    required this.image,
    required this.currentStep,
    this.price,
    this.type,
    this.name,
  });

  final int? price;
  final int currentStep;
  final int checkId;
  final String image;
  final String? type;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (currentStep == 1) {
          if (checkId == 100) {
            StartDesignCubit.get(context).pickImage();
          } else {
            StartDesignCubit.get(context).changeCheck(checkId, type ?? '');
            StartDesignCubit.get(context).changeStep(1);
            debugPrint('checkId: $checkId');
          }
        } else if (currentStep == 6 &&
            !StartDesignCubit.get(context).modelChecked.contains(checkId)) {
          StartDesignCubit.get(context).changeModelCheck(checkId);
          StartDesignCubit.get(context).getProductSizesAndColors(checkId);

          StartDesignCubit.get(context).changeStep(6);
          StartDesignCubit.get(context).changeColorCheck(StartDesignCubit.get(context).colors[0].id!);

          debugPrint('colorId: ${StartDesignCubit.get(context).colors[0].id}');

        }
      },
      child: BlocBuilder<StartDesignCubit, StartDesignState>(
        builder: (context, state) {
          final cubit = StartDesignCubit.get(context);
          ImageProvider<Object> imageProvider;

          if (checkId == 100 && cubit.selectedImage != null) {
            imageProvider =
                FileImage(StartDesignCubit.get(context).selectedImage!);
          } else if (checkId == 100) {
            imageProvider = AssetImage(AppAssets.uploadImage);
          } else {
            imageProvider = CachedNetworkImageProvider(
              image,
            );
          }
          return Container(
            width: 110.w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                  image: DecorationImage(
                    image: AssetImage(AppAssets.containerBackground),
                    fit: BoxFit.cover,
                    opacity: 0.9,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, 4.h),
                      child: Visibility(
                        visible: currentStep == 6,
                        child: Align(
                          child: TextBody12(
                            name ?? '',
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        BlocBuilder<StartDesignCubit, StartDesignState>(
                          builder: (context, state) {
                            return Transform.scale(
                              scale: 1,
                              child: SizedBox(
                                child: Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: currentStep == 1
                                      ? StartDesignCubit.get(context)
                                          .isChecked(checkId, type ?? 'images')
                                      : StartDesignCubit.get(context)
                                          .isModelChecked(checkId),
                                  onChanged: (value) {
                                    if (currentStep == 1) {
                                      if (checkId == 100) {
                                        StartDesignCubit.get(context)
                                            .pickImage();
                                      }
                                      StartDesignCubit.get(context)
                                          .changeCheck(checkId, type ?? '');
                                      StartDesignCubit.get(context)
                                          .changeStep(1);
                                    } else if (currentStep == 6) {
                                      StartDesignCubit.get(context)
                                          .changeModelCheck(checkId);
                                      StartDesignCubit.get(context)
                                          .getProductSizesAndColors(checkId);
                                      StartDesignCubit.get(context).changeColorCheck(StartDesignCubit.get(context).colors[0].id!);

                                      StartDesignCubit.get(context)
                                          .changeStep(6);
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  activeColor: AppColors.primaryColor,
                                  checkColor: AppColors.white,
                                  side: BorderSide(
                                    color:
                                        AppColors.black.withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        Visibility(
                            visible: currentStep != 6,
                            child: TextBody14('$price ر.س',
                                color: AppColors.black)),
                        Visibility(
                          visible: currentStep == 6,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  cubit.incrementNumber(checkId);
                                  StartDesignCubit.get(context).changeColorCheck(StartDesignCubit.get(context).colors[0].id!);

                                },
                                child: Container(
                                  height: 16.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withAlpha(140),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: TextBody12('+'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 16.h,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Center(
                                  child: TextBody12(
                                    fontSize: 11.sp,
                                    '${cubit.getProductCount(checkId)}', // Display the dynamic count
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.decrementNumber(checkId);
                                },
                                child: Container(
                                  height: 16.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withAlpha(140),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: TextBody14('-'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
