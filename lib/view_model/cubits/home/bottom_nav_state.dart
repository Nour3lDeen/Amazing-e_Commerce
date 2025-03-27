part of 'bottom_nav_cubit.dart';

@immutable
abstract class BottomNavState {}

final class BottomNavInitial extends BottomNavState {}

final class GetSocialLinksLoadingState extends BottomNavState {}

final class GetSocialLinksSuccessState extends BottomNavState {
  final List<Social> socialMedia;

  GetSocialLinksSuccessState(this.socialMedia);
}

final class GetSocialLinksErrorState extends BottomNavState {
  final String msg;

  GetSocialLinksErrorState(this.msg);
}

final class GetPoliciesLoadingState extends BottomNavState {}

final class GetPoliciesSuccessState extends BottomNavState {}

final class GetPoliciesErrorState extends BottomNavState {
  final String msg;

  GetPoliciesErrorState(this.msg);
}

class ToggleFavoriteLoadingState extends BottomNavState {}
class ToggleFavoriteErrorState extends BottomNavState {
  final String msg;

  ToggleFavoriteErrorState(this.msg);
}

class ChangeFavoriteState extends BottomNavState {
  final int productId;
  final bool isFavorite;

  ChangeFavoriteState(this.productId, this.isFavorite);
}

final class BottomNavChanged extends BottomNavState {
  final int index;

  BottomNavChanged(this.index);
}

final class GetSettingsLoadingState extends BottomNavState {}

final class GetSettingsSuccessState extends BottomNavState {}

final class GetSettingsErrorState extends BottomNavState {
  final String msg;

  GetSettingsErrorState(this.msg);
}

final class GetFavoritesLoadingState extends BottomNavState {}

final class GetFavoritesSuccessState extends BottomNavState {}

final class GetFavoritesErrorState extends BottomNavState {
  final String msg;

  GetFavoritesErrorState(this.msg);
}
final class GetSlidersLoadingState extends BottomNavState {}

final class GetSlidersSuccessState extends BottomNavState {}

final class GetSlidersErrorState extends BottomNavState {
  final String msg;

  GetSlidersErrorState(this.msg);
}
