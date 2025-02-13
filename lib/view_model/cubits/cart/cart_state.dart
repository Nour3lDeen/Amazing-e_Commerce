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

final class DeleteCartItemLoadingState extends CartState {}

final class DeleteCartItemSuccessState extends CartState {}

final class DeleteCartItemErrorState extends CartState {
  final String error;

  DeleteCartItemErrorState(this.error);
}final class ShowHistoryLoadingState extends CartState {}

final class ShowHistorySuccessState extends CartState {}

final class ShowHistoryErrorState extends CartState {
  final String error;

  ShowHistoryErrorState(this.error);
}



final class ChangeNumberState extends CartState {
  final int number;

  ChangeNumberState(this.number);
}
