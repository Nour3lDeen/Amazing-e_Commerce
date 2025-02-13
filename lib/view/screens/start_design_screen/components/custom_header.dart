import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../view_model/cubits/start_design/start_design_cubit.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader(
      {super.key,
      required this.title,
      required this.menuId,
      required this.isModel});

  final String title;
  final int menuId;
  final bool isModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartDesignCubit, StartDesignState>(
      builder: (context, openMenuId) {
        bool isOpen = StartDesignCubit.get(context).openMenuId == menuId;
        bool isModelOpen =
            StartDesignCubit.get(context).openModelMenuId == menuId;

        return GestureDetector(
          onTap: () {
            if (!isModel) {
              if (!isOpen) {
                StartDesignCubit.get(context).openMenu(menuId);
               if(menuId == 1) {
                  StartDesignCubit.get(context).getExamples();
                }else if(menuId == 2) {
                  StartDesignCubit.get(context).getNames();
                }else if(menuId == 3) {
                  StartDesignCubit.get(context).getLogos();
                }else if(menuId == 5) {
                  StartDesignCubit.get(context).getImages();
                }
               if (StartDesignCubit.get(context).currentStep != 1) {

               StartDesignCubit.get(context).changeStep(1);
               StartDesignCubit.get(context).scrollToTop();
               }
              } else if (isOpen) {
                StartDesignCubit.get(context).changeStep(1);
                StartDesignCubit.get(context).scrollToTop();
              }
            } else {
              if (!isModelOpen) {
                if (StartDesignCubit.get(context).currentStep != 6) {
                  StartDesignCubit.get(context).changeStep(6);
                }
                StartDesignCubit.get(context).openModelMenu(menuId);
                StartDesignCubit.get(context).getModelProducts(menuId);
              }
            }
          },
          child: Container(
            padding: !isModel ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h):null,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.primaryColor,
              ),
              gradient:(!isModel && isOpen)||(isModel && isModelOpen)
                  ? LinearGradient(colors: [
                      HexColor('#31D3C6'),
                      HexColor('#208B78'),
                    ])
                  : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextBody12(
                  title,
                  color:(!isModel && isOpen)||(isModel && isModelOpen)? AppColors.white : AppColors.black,
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset(
                  (!isModel && isOpen)||(isModel && isModelOpen) ? AppAssets.arrowUp : AppAssets.arrowDown,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
