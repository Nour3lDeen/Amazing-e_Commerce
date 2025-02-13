import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../utils/app_colors/app_colors.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());
  static BottomNavCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int newIndex) {
    currentIndex = newIndex;


    emit(BottomNavChanged(newIndex));
  }

  // Favorites: Use a Set to store IDs of favorite products
  final Set<int> favoriteProducts = {};

  void toggleFavorite(int productId,BuildContext context) {
    if (favoriteProducts.contains(productId)) {
      favoriteProducts.remove(productId); // Remove from favorites
      showToast('تم إزالة من المفضلة',
          context: context,
          position: StyledToastPosition.bottom,
          animation: StyledToastAnimation.scale,
          backgroundColor: Colors.red,
          reverseAnimation: StyledToastAnimation.fade,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
          borderRadius: BorderRadius.circular(25.r),
          isHideKeyboard: true,
          textStyle: TextStyle(
            color: AppColors.white,
            fontSize: 12.sp,
            fontFamily: 'Lamar',
          ));
    } else {
      favoriteProducts.add(productId); // Add to favorites
      showToast('تمت إضافة المنتج إلى المفضلة',
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          backgroundColor: Colors.green,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
          borderRadius: BorderRadius.circular(25.r),
          isHideKeyboard: true,
          textStyle: TextStyle(
            color: AppColors.white,
            fontSize: 12.sp,
            fontFamily: 'Lamar',
          ));
    }
    emit(ChangeFavoriteState(productId, favoriteProducts.contains(productId)));
  }

  bool isProductFavorite(int productId) {
    return favoriteProducts.contains(productId);
  }
}
