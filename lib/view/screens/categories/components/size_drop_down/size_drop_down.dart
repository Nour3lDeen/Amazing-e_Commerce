import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SizeDropdown extends StatelessWidget {
  const SizeDropdown({super.key, required this.sizes});
  final List<Sizes> sizes;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);

        // Filter out duplicate size codes
        final uniqueSizes = sizes.toSet().toList();

        // Debug: Print uniqueSizes
        debugPrint('Unique Sizes: ${uniqueSizes.map((size) => size.sizeCode).toList()}');

        // Debug: Print selectedSize
        debugPrint('Selected Size: ${cubit.selectedSize}');

        // Check if selectedSize is valid
        final isValidSelectedSize = uniqueSizes.any((size) => size.sizeCode == cubit.selectedSize);

        return Row(
          children: [
            TextBody12(
              'المقاس',
              color: AppColors.black,
            ),
            SizedBox(width: 10.w),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: DropdownButton<String>(
                isDense: true,
                borderRadius: BorderRadius.circular(8.r),
                dropdownColor: AppColors.white,
                icon: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: SvgPicture.asset(AppAssets.arrowDown),
                ),
                value: isValidSelectedSize ? cubit.selectedSize : null,
                items: uniqueSizes
                    .map((size) => DropdownMenuItem<String>(
                  value: size.sizeCode,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: TextBody12(size.sizeCode!),
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    cubit.changeSize(value);
                    debugPrint('Selected Size: $value');
                  }
                },
                underline: Container(),
              ),
            ),
          ],
        );
      },
    );
  }
}