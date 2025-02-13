import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view_model/cubits/start_design/start_design_cubit.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class CheckBoxComponent extends StatelessWidget {
  const CheckBoxComponent(
      {super.key,
      required this.title,
      required this.printId,
      required this.currentStep,
      required this.price});

  final String title;
  final String price;
  final int printId;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final cubit = StartDesignCubit.get(context);
    return GestureDetector(
      onTap: () {
        if (currentStep == 2) {
          cubit.changePrintCheck(printId);
          cubit.changeStep(2);
        } else if (currentStep == 3) {
          cubit.toggleMultiCheck(printId);
          cubit.changeStep(3);
        } else if (currentStep == 5) {
          cubit.changeMaterialCheck(printId);
          cubit.changeStep(5);
        } else if (currentStep == 7) {
          cubit.changeSizeCheck(printId);
          cubit.changeStep(7);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 0.8,
            child: SizedBox(
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: currentStep == 2
                    ? cubit.isPrintChecked(printId)
                    : currentStep == 3
                        ? cubit.isMultiChecked(printId)
                        : currentStep == 5
                            ? cubit.isMaterialChecked(printId)
                            : currentStep == 7
                                ? cubit.isSizeChecked(printId)
                                : false,
                onChanged: (value) {
                  if (currentStep == 2) {
                    cubit.changePrintCheck(printId);
                    cubit.changeStep(2);
                  } else if (currentStep == 3) {
                    cubit.toggleMultiCheck(printId);
                    cubit.changeStep(3);
                  } else if (currentStep == 5) {
                    cubit.changeMaterialCheck(printId);
                    cubit.changeStep(5);
                  } else if (currentStep == 7) {
                    if (cubit.currentStep != 7) {
                      cubit.changeStep(7);
                      cubit.scrollToPosition(1450);
                    }
                    cubit.changeSizeCheck(printId);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                activeColor: AppColors.primaryColor,
                checkColor: AppColors.white,
              ),
            ),
          ),
          Flexible(
            child: Transform.translate(
              offset: const Offset(5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 7.h),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.black,
                      fontFamily: 'Lamar',
                    ),
                    maxLines: 3, // Allow a maximum of 2 lines
                    overflow: TextOverflow.visible, // Make text visible
                    softWrap: true, // Allow wrapping to the next line
                  ),
                  Text(
                    '$price ر.س',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.grey,
                      fontFamily: 'Lamar',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
