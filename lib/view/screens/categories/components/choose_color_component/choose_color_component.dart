import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../model/sections_model/sections_model.dart';
import '../../../../../view_model/cubits/products/products_cubit.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class ChooseColorComponent extends StatelessWidget {
  const ChooseColorComponent({super.key, required this.product});
final Products product;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        ProductsCubit cubit = ProductsCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6.w,
          children: List.generate(
            product.colors!.length,
            (index) {
              return InkWell(
                onTap: () {
                  cubit.changeIsSelected(index);
                },
                child: Center(
                  child: Container(
                    width: 40.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.r),
                      boxShadow: [
                        cubit.isSelected(index)
                            ? BoxShadow(
                                color: AppColors.primaryColor
                                    .withValues(alpha: 0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 4),
                              )
                            : BoxShadow(
                                color: AppColors.grey,
                                blurRadius: 2,
                                offset: const Offset(0, 4),
                              )
                      ],
                      border: Border.all(
                        color: cubit.isSelected(index)
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        width: 1.sp,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(1.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              HexColor('${product.colors![index].colorCode}'),
                          borderRadius: BorderRadius.circular(6.r),
                          boxShadow: [
                            cubit.isColorChecked(product.colors![index].id!)
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
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
