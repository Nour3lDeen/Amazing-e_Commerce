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
                value: cubit.selectedSize??'',
                items: sizes
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
