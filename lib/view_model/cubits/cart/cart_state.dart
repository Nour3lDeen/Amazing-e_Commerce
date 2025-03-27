part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class ChangeIsSelectedState extends CartState {}

final class GetCartItemsLoadingState extends CartState {}

final class GetCartItemsSuccessState extends CartState {}

final class GetCartItemsErrorState extends CartState {
  final String error;

  GetCartItemsErrorState(this.error);
}

final class UpdateCartItemLoadingState extends CartState {}

final class UpdateCartItemSuccessState extends CartState {
  final String msg;

  UpdateCartItemSuccessState(this.msg);
}

final class UpdateCartItemErrorState extends CartState {
  final String error;

  UpdateCartItemErrorState(this.error);
}

final class DeleteCartItemLoadingState extends CartState {}

final class DeleteCartItemSuccessState extends CartState {}

final class DeleteCartItemErrorState extends CartState {
  final String error;

  DeleteCartItemErrorState(this.error);
}

final class ShowHistoryLoadingState extends CartState {}

final class ShowHistorySuccessState extends CartState {}

final class ShowHistoryErrorState extends CartState {
  final String error;

  ShowHistoryErrorState(this.error);
}

final class CheckoutLoadingState extends CartState {}

final class CheckoutSuccessState extends CartState {}

final class CheckoutErrorState extends CartState {
  final String error;

  CheckoutErrorState(this.error);
}

final class ToggleCouponState extends CartState {}

final class CheckCouponLoadingState extends CartState {}

final class CheckCouponSuccessState extends CartState {}

final class CheckCouponErrorState extends CartState {
  final String error;

  CheckCouponErrorState(this.error);
}

final class RemoveCouponLoadingState extends CartState {}

final class RemoveCouponSuccessState extends CartState {
  final String msg;

  RemoveCouponSuccessState(this.msg);
}

final class RemoveCouponErrorState extends CartState {
  final String error;

  RemoveCouponErrorState(this.error);
}

final class CancelOrderLoadingState extends CartState {}

final class CancelOrderSuccessState extends CartState {
  final String msg;

  CancelOrderSuccessState(this.msg);
}

final class CancelOrderErrorState extends CartState {
  final String error;

  CancelOrderErrorState(this.error);
}

final class GetReasonsLoadingState extends CartState {}

final class GetReasonsSuccessState extends CartState {}

final class GetReasonsErrorState extends CartState {
  final String error;

  GetReasonsErrorState(this.error);
}

final class SendRefundRequestLoadingState extends CartState {}

final class SendRefundRequestSuccessState extends CartState {
  final String msg;

  SendRefundRequestSuccessState(this.msg);
}

final class SendRefundRequestErrorState extends CartState {
  final String error;

  SendRefundRequestErrorState(this.error);
}

final class GetReturnedItemsLoadingState extends CartState {}

final class GetReturnedItemsSuccessState extends CartState {}

final class GetReturnedItemsErrorState extends CartState {
  final String error;

  GetReturnedItemsErrorState(this.error);
}

final class CancelReturnedLoadingState extends CartState {}

final class CancelReturnedSuccessState extends CartState {
  final String msg;

  CancelReturnedSuccessState(this.msg);
}

final class CancelReturnedErrorState extends CartState {
  final String error;

  CancelReturnedErrorState(this.error);
}

final class ChangeNumberState extends CartState {
  final int number;

  ChangeNumberState(this.number);
}

final class SelectAddressState extends CartState {
  final int id;

  SelectAddressState(this.id);
}

final class SelectPaymentMethodState extends CartState {
  final String paymentMethod;

  SelectPaymentMethodState(this.paymentMethod);
}

final class ChangeReasonState extends CartState {}
