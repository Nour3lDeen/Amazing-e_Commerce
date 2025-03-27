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


        final allSeasons = [
          {'name': 'الكل', 'index': -1},
          ...List.generate(
            cubit.seasons.length,
                (index) => {'name': cubit.seasons[index].name, 'index': index},
          ),
        ];

        return Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: DropdownButton<int>(
            items: allSeasons.map((season) {
              return DropdownMenuItem<int>(
                value: season['index'] as int,
                child: TextBody14(
                  season['name'] as String,
                  color: AppColors.black,
                ),
              );
            }).toList(),
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
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25), // Fixed opacity issue
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBody12(
                    cubit.selectedIndexSeason == -1
                        ? 'الكل'
                        : cubit.seasons[cubit.selectedIndexSeason].name!,
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
