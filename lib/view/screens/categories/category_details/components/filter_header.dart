import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';



class FilterHeader extends StatelessWidget {
  const FilterHeader({super.key, required this.index, required this.title});

  final int index;
final String title;
  @override
  Widget build(BuildContext context) {
    final cubit = ProductsCubit.get(context);

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final isSelected = cubit.isSelected(index);

        return InkWell(
          onTap: () {
            cubit.changeFilterSelected(index);
            cubit.getCategoryProduct(index);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.sp),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(colors: [
                HexColor('#49F2D5'),
                HexColor('#09AC90'),
              ])
                  : null,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            child: Center(
              child: TextBody12(
                title,
                  color: isSelected ? AppColors.white : AppColors.black,

              ),
            ),
          ),
        );
      },
    );
  }
}
