import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../view_model/utils/Texts/Texts.dart';
import '../../../view_model/utils/app_assets/app_assets.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';

class SeasonsDropDown extends StatelessWidget {
  const SeasonsDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: DropdownButton(
            items: [
              DropdownMenuItem(
                value: 0,
                child: TextBody14(
                  cubit.seasons[0],
                  color: AppColors.black,
                ),
              ),
              DropdownMenuItem(
                value: 1,
                child: TextBody14(
                  cubit.seasons[1],
                  color: AppColors.black,
                ),
              ),
              DropdownMenuItem(
                value: 2,
                child: TextBody14(
                  cubit.seasons[2],
                  color: AppColors.black,
                ),
              ),
              DropdownMenuItem(
                value: 3,
                child: TextBody14(
                  cubit.seasons[3],
                  color: AppColors.black,
                ),
              ),
            ],
            onChanged: (value) {
              cubit.changeSeason(value!);
            },
            iconSize: 0,
            hint: Container(
              width: 70.w,
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: HexColor('#63C2B1'),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                  style: BorderStyle.solid,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBody12(
                    cubit.seasons[cubit.selectedIndexSeason],
                    color: AppColors.white,
                  ),
                  SvgPicture.asset(
                    AppAssets.arrowDown,
                    colorFilter: ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
        );
      },
    );
  }
}
