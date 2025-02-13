import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key,});

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: FloatingSearchBarController(),
      backgroundColor: Colors.grey.shade200,
      leadingActions: [
        SvgPicture.asset(
          AppAssets.search,
          height: 14.h,
          width: 14.w,
        ),
      ],
      borderRadius: BorderRadius.circular(24.r),
      hint: 'بحث عن منتج',
      hintStyle: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 12.sp,
        fontFamily: 'Lamar',
      ),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      width: 175.w,
      height: 28.h,
      openAxisAlignment: 0.0,
      backdropColor: Colors.transparent,
      debounceDelay: const Duration(milliseconds: 200),
      onQueryChanged: (query) {
        debugPrint('Search Query: $query');
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: const [],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white.withValues(alpha: .7),
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                    (index) => ListTile(
                  title: Text('المنتج  ${index + 1}'),
                  onTap: () {
                    debugPrint('Suggestion $index tapped');
                  },
                ),
              ),
            ),
          ),
        );
      },
    ) ;
  }
}
