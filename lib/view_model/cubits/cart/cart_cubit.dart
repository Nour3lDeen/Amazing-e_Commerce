import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/cart_item_model/cart_item_model.dart';
import 'package:ecommerce/model/cart_item_model/history_cart_model.dart';
import 'package:ecommerce/model/reason/reason_model.dart';
import 'package:ecommerce/model/returned/returned_model.dart';
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

  /// Variables
  final TextEditingController couponController = TextEditingController();
  bool isSelected = true;
  bool isHistory = false;
  final Map<int, int> productCounts = {};
  int selectedAddress = -1;
  String selectedPaymentMethod = 'wallet';
  List<CartItems> cartItems = [];
  CartItem? cartItem;
  List<HistoryCartItem> historyCartItems = [];
  List<OrderItems> orderItems = [];
  bool activeCoupon = false;
  List<Reason> reasons = [];
  String selectedReason = '';
  int selectedReasonId = -1;
  List<ReturnedModel> returnedItems = [];

  /// Logic Methods
  void changeIsSelected(bool value, bool isHistory) {
    isSelected = value;
    this.isHistory = isHistory;
    emit(ChangeIsSelectedState());
  }

  void incrementNumber(int productId) {
    int.parse(cartItems
        .firstWhere((item) => item.product!.id == productId)
        .quantity
        .toString());
    emit(ChangeNumberState(0));
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
    return productCounts.putIfAbsent(productId, () => 1);
  }

  void selectAddress(int addressId) {
    if (selectedAddress != addressId) {
      selectedAddress = addressId;
      debugPrint('selectedAddress: $selectedAddress');
      emit(SelectAddressState(addressId));
    }
  }

  bool isAddressSelected(int addressId) {
    return selectedAddress == addressId;
  }

  void selectPaymentMethod(String paymentMethod) {
    if (selectedPaymentMethod != paymentMethod) {
      selectedPaymentMethod = paymentMethod;
      debugPrint('selectedPaymentMethod: $selectedPaymentMethod');
      emit(SelectPaymentMethodState(paymentMethod));
    }
  }

  String localizeStatus(String status) {
    switch (status) {
      case 'pending':
        return 'قيد المراجعة';
      case 'processing':
        return 'جاري التحضير';
      case 'delivered':
        return 'تم التوصيل';
      case 'shipping':
        return 'جاري الشحن';
      case 'completed':
        return 'منتهي';
      case 'returned':
        return 'مرتجع';
      case 'canceled':
        return 'ملغي';
      default:
        return status;
    }
  }

  Color statusColor(String status) {
    switch (status) {
      case 'pending':
        return AppColors.pending;
      case 'processing':
        return AppColors.processing;
      case 'delivered':
        return AppColors.delivered;
      case 'shipping':
        return AppColors.shipping;
      case 'completed':
        return AppColors.completed;
      case 'returned':
        return AppColors.returned;
      case 'canceled':
        return AppColors.canceled;
      default:
        return AppColors.pending;
    }
  }

  void toggleCoupon() {
    activeCoupon = !activeCoupon;
    emit(ToggleCouponState());
  }

  void changeReason(String reason) {
    selectedReason = reason;
    selectedReasonId =
        reasons.firstWhere((element) => element.name == reason).id ?? 0;
    debugPrint(selectedReasonId.toString());
    emit(ChangeReasonState());
  }

  /// Backend Methods
  void getCartItems() {
    debugPrint('Getting cart items...');
    final token = SharedHelper.getData(SharedKeys.token);
    debugPrint('Token: $token');
    emit(GetCartItemsLoadingState());

    DioHelper.get(path: EndPoints.carts, withToken: true).then((value) {
      try {
        debugPrint('Raw response: ${value.data}');
        if (value.data == null || value.data['data'] == null) {
          cartItems.clear();
          emit(GetCartItemsErrorState('Error: No data received from server.'));
          debugPrint('Error: No data received from server.');
          return;
        }

        final cartData = value.data['data'];
        cartItem = CartItem.fromJson(cartData);
        if (cartData['cartitems'] is List) {
          cartItems = (cartData['cartitems'] as List)
              .map((item) => CartItems.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          cartItems = [];
        }

        debugPrint('Cart item: $cartItem');
        debugPrint('Cart items list: $cartItems');

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

  void updateCartItem({
    required int productId,
    required int cartId,
    required int quantity,
    required String operation,
    required int sizeId,
  }) {
    emit(UpdateCartItemLoadingState());
    if (operation == 'decrement') {
      quantity--;
    } else {
      quantity++;
    }
    final Map<String, dynamic> data = {
      'product_id': productId.toString(),
      'quantity': quantity.toString(),
      'size_id': sizeId.toString(),
    };

    debugPrint('Updating cart item...');
    debugPrint('Request Data: $data');

    DioHelper.put(
      path: '${EndPoints.carts}/$cartId',
      withToken: true,
      body: data,
    ).then((value) {
      debugPrint('Response: ${value.data}');

      if (value.data != null &&
          value.data['message'] != null &&
          value.data['statusCode'] == 200) {
        getCartItems();
        emit(UpdateCartItemSuccessState(value.data['message']));
      } else {
        emit(UpdateCartItemErrorState(value.data['message']));
        debugPrint('Error: Unexpected response format.');
      }
    }).catchError((error) {
      if (error is DioException) {
        debugPrint('DioException: ${error.type}');
        debugPrint('Response: ${error.response?.data}');
        debugPrint('Status Code: ${error.response?.statusCode}');
        emit(UpdateCartItemErrorState(
            'Error: ${error.response?.data['message'] ?? 'Failed to update cart item'}'));
      } else {
        debugPrint('Unexpected Error: $error');
        emit(UpdateCartItemErrorState('Unexpected error occurred: $error'));
      }
    });
  }

  void deleteCartItem(BuildContext context, int cartItemId) {
    emit(DeleteCartItemLoadingState());
    DioHelper.delete(path: '${EndPoints.carts}/$cartItemId', withToken: true)
        .then((value) {
      debugPrint('Response: ${value.data}');
      getCartItems();
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

  void showHistory() {
    emit(ShowHistoryLoadingState());

    DioHelper.get(path: EndPoints.orders, withToken: true).then((value) {
      try {
        debugPrint('Raw response: ${value.data}');

        if (value.data == null || value.data['statusCode'] != 200) {
          emit(ShowHistoryErrorState(
              value.data['message'] ?? 'Error: Unexpected response.'));
          return;
        }

        final orders = value.data['data'];
        if (orders is! List) {
          emit(ShowHistoryErrorState(
              'Error: Orders data format is not a list.'));
          return;
        }

        debugPrint('Orders fetched successfully: ${orders.runtimeType}');

        historyCartItems.clear();
        orderItems.clear();

        for (var order in orders) {
          debugPrint('Order: $order');

          try {
            final historyCartItem =
                HistoryCartItem.fromJson(order as Map<String, dynamic>);
            historyCartItems.add(historyCartItem);
            if (order.containsKey('orderitems') &&
                order['orderitems'] is List) {
              final items = (order['orderitems'] as List).map((item) {
                return OrderItems.fromJson(item as Map<String, dynamic>);
              }).toList();
              orderItems.addAll(items);
            }
          } catch (e) {
            debugPrint('Error parsing order: $order');
            debugPrint('Exception: $e');
          }
        }

        debugPrint(
            'Orders fetched successfully: ${historyCartItems.toString()}');
        debugPrint(
            'Orders Items fetched successfully: ${orderItems.toString()}');
        emit(ShowHistorySuccessState());
      } catch (e) {
        emit(ShowHistoryErrorState('$e'));
        debugPrint('Error parsing orders: $e');
      }
    }).catchError((error) {
      debugPrint('Unexpected Error: $error');
      emit(ShowHistoryErrorState(error.toString()));
    });
  }

  void checkout() {
    final formData = FormData.fromMap({
      'data[address][address_id]': selectedAddress,
      'data[payment][payment_method]': selectedPaymentMethod
    });
    emit(CheckoutLoadingState());
    DioHelper.post(path: EndPoints.orders, withToken: true, body: formData)
        .then((value) {
      if (value.data['statusCode'] != 200) {
        emit(CheckoutErrorState(value.data['message']));
      } else {
        debugPrint('Response: ${value.data}');
        emit(CheckoutSuccessState());
      }
    }).catchError((error) {
      debugPrint('Error: $error');
      emit(CheckoutErrorState(error.toString()));
    });
  }

  void checkCoupon() {
    emit(CheckCouponLoadingState());
    DioHelper.post(
        path: EndPoints.coupons,
        withToken: true,
        body: {'coupon': couponController.text}).then((value) {
      debugPrint('Response: ${value.data}');
      if (value.data['statusCode'] != 200) {
        emit(CheckCouponErrorState(value.data['message']));
      } else {
        toggleCoupon();
        emit(CheckCouponSuccessState());
      }
    }).catchError((error) {
      debugPrint('Error25: $error');
      emit(CheckCouponErrorState(error.toString()));
    });
  }

  void removeCoupon() {
    emit(RemoveCouponLoadingState());
    DioHelper.post(path: EndPoints.removeCoupons, withToken: true)
        .then((value) {
      debugPrint('Response: ${value.data}');
      if (value.data['statusCode'] != 200) {
        emit(RemoveCouponErrorState(value.data['message']));
      } else {
        toggleCoupon();
        couponController.clear();
        getCartItems();
        emit(RemoveCouponSuccessState(value.data['message']));
      }
    }).catchError((error) {
      debugPrint('Error: $error');
      emit(RemoveCouponErrorState(error.toString()));
    });
  }

  void cancelOrder(int orderId) {
    emit(CancelOrderLoadingState());
    DioHelper.put(
        path: '${EndPoints.orders}/canceled/$orderId',
        withToken: true,
        body: {'status': 'canceled'}).then((value) {
      debugPrint('Response: ${value.data}');
      if (value.data['statusCode'] != 200) {
        emit(CancelOrderErrorState(value.data['message']));
      } else {
        historyCartItems.clear();
        orderItems.clear();
        showHistory();
        emit(CancelOrderSuccessState(value.data['message']));
      }
    }).catchError((error) {
      debugPrint('Error: $error');
      emit(CancelOrderErrorState(error.toString()));
    });
  }

  void getReasons() {
    emit(GetReasonsLoadingState());
    DioHelper.get(path: EndPoints.reasons, withToken: true).then((value) {
      debugPrint('Response: ${value.data}');
      if (value.data['statusCode'] != 200) {
        emit(GetReasonsErrorState(value.data['message']));
      } else {
        reasons = (value.data['data'] as List)
            .map((reasonJson) => Reason.fromJson(reasonJson))
            .toList();
        debugPrint('Reasons: ${reasons.toString()}');
        emit(GetReasonsSuccessState());
      }
    }).catchError((error) {
      debugPrint('Error: $error');
      emit(GetReasonsErrorState(error.toString()));
    });
  }

  void sendRefundRequest({
    required int orderId,
    required int quantity,
    required String type,
    required String refundType,
  }) {
    emit(SendRefundRequestLoadingState());
    final formData;
    if (type == 'normal') {
      formData = FormData.fromMap({
        'orderitem_id': orderId,
        'quantity': quantity,
        'reason_id': selectedReasonId,
        'type': type,
        'amount_refund_type': refundType,
      });
    } else {
      formData = FormData.fromMap({
        'orderitem_id': orderId,
        'quantity': quantity,
        'type': type,
      });
    }
    DioHelper.post(path: EndPoints.returned, withToken: true, body: formData)
        .then((value) {
      debugPrint('Response of refund: ${value.data}');
      if (value.data['statusCode'] != 200) {
        emit(SendRefundRequestErrorState(value.data['message']));
      } else {
        emit(SendRefundRequestSuccessState(value.data['message']));
      }
    }).catchError((error) {
      debugPrint('Error: $error');
      emit(SendRefundRequestErrorState(error.toString()));
    });
  }

  void getReturnedItems() {
    emit(GetReturnedItemsLoadingState());
    DioHelper.get(path: EndPoints.returned, withToken: true).then((value) {
      debugPrint('Response: ${value.data}');
      if (value.data['statusCode'] != 200) {
        emit(GetReturnedItemsErrorState(value.data['message']));
      } else {
        returnedItems = (value.data['data'] as List)
            .map((reasonJson) => ReturnedModel.fromJson(reasonJson))
            .toList();
        debugPrint('Returned Items: ${returnedItems.toString()}');
        emit(GetReturnedItemsSuccessState());
      }
    }).catchError((error) {
      debugPrint('Error: $error');
      emit(GetReturnedItemsErrorState(error.toString()));
    });
  }

  void cancelReturned(int returnedId) {
    debugPrint('returnedId: $returnedId');
    emit(CancelReturnedLoadingState());
    DioHelper.delete(path: '${EndPoints.returned}/$returnedId', withToken: true)
        .then((value) {
      debugPrint('Response: ${value.data}');
      if (value.data['statusCode'] != 200) {
        emit(CancelReturnedErrorState(value.data['message']));
      } else {
        debugPrint(value.data['message']);
        getReturnedItems();
        emit(CancelReturnedSuccessState(value.data['message']));
      }
    }).catchError((error) {
      debugPrint('Error: $error');
      emit(CancelReturnedErrorState(error.toString()));
    });
  }
}
