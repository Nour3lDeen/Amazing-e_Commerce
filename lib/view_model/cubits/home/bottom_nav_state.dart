part of 'bottom_nav_cubit.dart';

@immutable
abstract class BottomNavState {}

final class BottomNavInitial extends BottomNavState {}

class ChangeFavoriteState extends BottomNavState {
  final int productId;
  final bool isFavorite;
  ChangeFavoriteState(this.productId, this.isFavorite);
}

final class BottomNavChanged extends BottomNavState {
  final int index;

  BottomNavChanged(this.index);
}
