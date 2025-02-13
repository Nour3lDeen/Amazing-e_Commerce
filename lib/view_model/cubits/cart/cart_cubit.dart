import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce/model/cart_item_model/cart_item_model.dart';
import 'package:ecommerce/model/cart_item_model/history_cart_model.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../data/local/shared_keys.dart';
import '../../data/network/dio_helper.dart';
import '../../data/network/endpoints.dart';
import '../../utils/app_colors/app_colors.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);

  bool isSelected = true;
  bool isHistory = false;

  void changeIsSelected(bool value, bool isHistory) {
    isSelected = value;
    this.isHistory = isHistory;

    emit(ChangeIsSelectedState());
  }

  final Map<int, int> productCounts = {};

  void incrementNumber(int productId) {
    productCounts.update(
      productId,
          (currentCount) => currentCount + 1,
      ifAbsent: () =>
      1, // Initialize to 1 if the product is not already in the map
    );

    emit(ChangeNumberState(productCounts[productId]!));
  }

  void decrementNumber(int productId) {
    if (productCounts.containsKey(productId) && productCounts[productId]! > 1) {
      productCounts.update(
        productId,
            (currentCount) => currentCount - 1,
      );

      emit(ChangeNumberState(productCounts[productId]!));
    }
  }

  int getProductCount(int productId) {
    // Ensure the first number for any product is 1 by default
    return productCounts.putIfAbsent(productId, () => 1);
  }

  Timer? _timer;

  void startIncrementing(int index) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      incrementNumber(index);
    });
  }

  void startDecrementing(int index) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      decrementNumber(index);
    });
  }

  void stopIncrementing() {
    _timer?.cancel();
  }

  void stopDecrementing() {
    _timer?.cancel();
  }

  /// backend
  List<CartItem> cartItems = [];

  void getCartItems() {
    debugPrint('Getting cart items...');
    final token = SharedHelper.getData(SharedKeys.token);
    debugPrint('Token: $token');
    emit(GetCartItemsLoadingState());

    DioHelper.get(path: EndPoints.carts, withToken: true).then((value) {
      try {
        debugPrint('Raw response: ${value.data}');

        // Check if response contains the expected structure
        if (value.data == null || value.data['data'] == null) {
          emit(GetCartItemsErrorState('Error: No data received from server.'));
          debugPrint('Error: No data received from server.');
          return;
        }

        final cartData = value.data['data'];
        if (cartData['cartitems'] is! List) {
          emit(GetCartItemsErrorState(
              'Error: Cart items data format is not a list.'));
          debugPrint('Error: Cart items data format is not a list.');
          return;
        }

        // Extract cart items and map to your model
        final data = (cartData['cartitems'] as List)
            .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
            .toList();
        cartItems = data; // Assign cart items
        debugPrint('Cart items fetched successfully: $cartItems');
        emit(GetCartItemsSuccessState());
      } catch (e) {
        emit(GetCartItemsErrorState('Parsing error: $e'));
        debugPrint('Error parsing cart items: $e');
      }
    }).catchError((error) {
      if (error is DioException) {
        debugPrint('Error Type: ${error.type}');
        debugPrint('Error Response: ${error.response?.data}');
        debugPrint('Error Status Code: ${error.response?.statusCode}');
      } else {
        debugPrint('Unexpected Error: $error');
      }
      emit(GetCartItemsErrorState(error.toString()));
    });
  }


  void deleteCartItem(BuildContext context, int cartItemId) {
    emit(DeleteCartItemLoadingState());
    DioHelper.delete(path: '${EndPoints.carts}/$cartItemId', withToken: true)
        .then((value) {
      debugPrint('Response: ${value.data}');

      // Remove item locally from the list
      cartItems.removeWhere((item) => item.id == cartItemId);
      showToast('تم حذف المنتج من السلة',
          context: context,
          backgroundColor: AppColors.red,
          position: StyledToastPosition.bottom,
          animation: StyledToastAnimation.scale,
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
      emit(DeleteCartItemSuccessState());
    }).catchError((error) {
      debugPrint('Error: $error');
      emit(DeleteCartItemErrorState(error.toString()));
    });
  }
List<HistoryCartItem> historyCartItems = [];
  void showHistory() {
    emit(ShowHistoryLoadingState());

    DioHelper.get(path: EndPoints.orders, withToken: true).then((value) {
      try {
        debugPrint('Raw response: ${value.data}');

        if (value.data == null || value.data['data'] == null) {
          emit(ShowHistoryErrorState('Error: No data received from server.'));
          return;
        }

        final orders = value.data['data'];
        if (orders is! List) {
          emit(ShowHistoryErrorState('Error: Orders data format is not a list.'));
          return;
        }

        historyCartItems = orders
            .map((order) => HistoryCartItem.fromJson(order as Map<String, dynamic>))
            .toList();

        debugPrint('Orders fetched successfully: $historyCartItems');
        emit(ShowHistorySuccessState());
      } catch (e) {
        emit(ShowHistoryErrorState('Parsing error: $e'));
        debugPrint('Error parsing orders: $e');
      }
    }).catchError((error) {
      debugPrint('Unexpected Error: $error');
      emit(ShowHistoryErrorState(error.toString()));
    });
  }
}