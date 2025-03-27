part of 'products_cubit.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ChangeSeasonState extends ProductsState {}

class ChangeSelectedSectionState extends ProductsState {}

class ChangeOfferState extends ProductsState {}

class ChangeFavoriteState extends ProductsState {
  final int productId;
  final bool isFavorite;

  ChangeFavoriteState(this.productId, this.isFavorite);
}

class ProductsScrollState extends ProductsState {
  final bool isScrolledDown;

  ProductsScrollState(this.isScrolledDown);
}

class ProductsIsSelectedState extends ProductsState {
  final int selectedIndex;

  ProductsIsSelectedState(this.selectedIndex);
}

class ProductsSizeChangedState extends ProductsState {
  final String newSize;

  ProductsSizeChangedState(this.newSize);
}

class ProductsColorChangedState extends ProductsState {
  final int id;

  ProductsColorChangedState(this.id);
}

final class ChangeNumberState extends ProductsState {
  final int number;

  ChangeNumberState(this.number);
}

final class ChangeRefundTypeState extends ProductsState {}

final class SendRateLoadingState extends ProductsState {}

final class SendRateSuccessState extends ProductsState {}

final class SendRateErrorState extends ProductsState {
  String msg;

  SendRateErrorState(this.msg);
}

final class SectionLoadingState extends ProductsState {}

final class SectionSuccessState extends ProductsState {}

final class SectionErrorState extends ProductsState {
  String msg;

  SectionErrorState(this.msg);
}

final class SectionsLoadingState extends ProductsState {}

final class SectionsSuccessState extends ProductsState {}

final class SectionsErrorState extends ProductsState {
  String msg;

  SectionsErrorState(this.msg);
}

final class CategoriesLoadingState extends ProductsState {}

final class CategoriesSuccessState extends ProductsState {}

final class CategoriesErrorState extends ProductsState {
  String msg;

  CategoriesErrorState(this.msg);
}

final class ProductsLoadingState extends ProductsState {}

final class ProductsSuccessState extends ProductsState {}

final class ProductsErrorState extends ProductsState {
  String msg;

  ProductsErrorState(this.msg);
}

final class GetProductsLoadingState extends ProductsState {}

final class GetProductsSuccessState extends ProductsState {}

final class GetProductsErrorState extends ProductsState {
  String msg;

  GetProductsErrorState(this.msg);
}

final class GetSeasonsLoadingState extends ProductsState {}

final class GetSeasonsSuccessState extends ProductsState {}

final class GetSeasonsErrorState extends ProductsState {
  String msg;

  GetSeasonsErrorState(this.msg);
}

final class ProductLoadingState extends ProductsState {}

final class ProductSuccessState extends ProductsState {}

final class ProductErrorState extends ProductsState {
  String msg;

  ProductErrorState(this.msg);
}

final class ChangeSelectedImageState extends ProductsState {
  String imageUrl;

  ChangeSelectedImageState(this.imageUrl);
}

final class ProductsUpdatedState extends ProductsState {}

final class ProductsSearchQueryUpdatedState extends ProductsState {}

final class StackUpdatedState extends ProductsState {
  final List<String> stack;

  StackUpdatedState(this.stack);
}

/// State when the video is loading
class ProductsLoading extends ProductsState {}

/// State when the video is successfully loaded
class ProductsVideoLoaded extends ProductsState {
  final VideoPlayerController videoController;
  final ChewieController chewieController;
  final bool isVideoPressed;

  ProductsVideoLoaded({
    required this.videoController,
    required this.chewieController,
    required this.isVideoPressed,
  });
}

/// State when an error occurs
class ProductsError extends ProductsState {
  final String errorMessage;

  ProductsError(this.errorMessage);
}

final class AddCartItemLoadingState extends ProductsState {}

final class AddCartItemSuccessState extends ProductsState {}

final class AddCartItemErrorState extends ProductsState {
  final String error;

  AddCartItemErrorState(this.error);
}

final class ChangeButtonState extends ProductsState {}

final class GetFavoritesLoadingState extends ProductsState {}

final class GetFavoritesSuccessState extends ProductsState {}

final class GetFavoritesErrorState extends ProductsState {
  final String msg;

  GetFavoritesErrorState(this.msg);
}

final class ToggleFavoriteLoadingState extends ProductsState {}

final class ToggleFavoriteErrorState extends ProductsState {
  final String msg;

  ToggleFavoriteErrorState(this.msg);
}
