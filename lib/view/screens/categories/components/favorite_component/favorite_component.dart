import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/cubits/products/products_cubit.dart';
import '../../../../../view_model/utils/app_assets/app_assets.dart';

class FavoriteComponent extends StatelessWidget {
  const FavoriteComponent({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) =>
          current is ChangeFavoriteState && current.productId == productId,
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);
        final isFavorite = cubit.isProductFavorite(productId);

        return GestureDetector(
          onTap: () {
            cubit.toggleFavorite(productId, context);
          },
          child: Container(

            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.6),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0,0),
                )
              ],
            ),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: AnimatedScale(
                scale: isFavorite ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Padding(
                  padding: EdgeInsets.all(4.sp),
                  child: SvgPicture.asset(
                    AppAssets.heart,
                    colorFilter: isFavorite
                        ? ColorFilter.mode(
                            HexColor('#FF5555'), BlendMode.srcIn)
                        : null,
                    height: 12.h,
                    width: 12.w,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
