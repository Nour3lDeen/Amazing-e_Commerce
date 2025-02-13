import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../../view_model/utils/app_colors/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: HexColor('#DCDCDC').withValues(alpha: 0.7),

          ),
          child: Padding(
            padding: EdgeInsets.symmetric( vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildNavItem(
                    icon: AppAssets.home,
                    index: 0,
                    isSelected: currentIndex == 0,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    icon: AppAssets.scissors,
                    index: 1,
                    isSelected: currentIndex == 1,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    icon: AppAssets.clothes,
                    index: 2,
                    isSelected: currentIndex == 2,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    icon: AppAssets.cart,
                    index: 3,
                    isSelected: currentIndex == 3,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    icon: AppAssets.others,
                    index: 4,
                    isSelected: currentIndex == 4,
                    onTap: onTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String icon,
    required int index,
    required bool isSelected,
    required Function(int) onTap,
  }) {
    return InkWell(
      onTap: () => onTap(index),
      child: SvgPicture.asset(
        icon,
        height: isSelected ? 24.h : 20.h,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.primaryColor : AppColors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
