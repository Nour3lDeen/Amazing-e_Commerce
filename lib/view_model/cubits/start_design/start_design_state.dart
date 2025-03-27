part of 'start_design_cubit.dart';

@immutable
sealed class StartDesignState {}

final class StartDesignInitial extends StartDesignState {}

final class OpenMenuState extends StartDesignState {}

final class CloseMenuState extends StartDesignState {}

final class ChangeCheckState extends StartDesignState {
  final int checkId;
  final bool isChecked;

  ChangeCheckState(this.checkId, this.isChecked);
}
final class ChangeColorCheckState extends StartDesignState {
  final int checkId;
  final bool isColorChecked;

  ChangeColorCheckState(this.checkId, this.isColorChecked);
}

final class ChangeMaterialCheckState extends StartDesignState {
  final int checkId;
  final bool isMaterialChecked;

  ChangeMaterialCheckState(this.checkId, this.isMaterialChecked);
}

final class ChangeStepState extends StartDesignState {}

class ChangeMultiCheckState extends StartDesignState {
  final Set<int> multiChecked;

  ChangeMultiCheckState(this.multiChecked);
}

class ScrollPositionChangedState extends StartDesignState {
  final double position;

  ScrollPositionChangedState(this.position);
}

class ColorChangedState extends StartDesignState {
  final Color color;

  ColorChangedState(this.color);
}

final class GetExamplesLoadingState extends StartDesignState {}

final class GetExamplesSuccessState extends StartDesignState {}

final class GetExamplesErrorState extends StartDesignState {}

final class GetPrintTypesLoadingState extends StartDesignState {}

final class GetPrintTypesSuccessState extends StartDesignState {}

final class GetPrintTypesErrorState extends StartDesignState {}

final class GetSizesAndDirectionsLoadingState extends StartDesignState {}

final class GetSizesAndDirectionsSuccessState extends StartDesignState {}

final class GetSizesAndDirectionsErrorState extends StartDesignState {}

final class GetMaterialLoadingState extends StartDesignState {}

final class GetMaterialSuccessState extends StartDesignState {}

final class GetMaterialErrorState extends StartDesignState {}

final class GetModelLoadingState extends StartDesignState {}

final class GetModelSuccessState extends StartDesignState {}

final class GetModelErrorState extends StartDesignState {}

final class GetProductLoadingState extends StartDesignState {}

final class GetProductSuccessState extends StartDesignState {}

final class GetProductErrorState extends StartDesignState {}
class GetProductSizesLoadingState extends StartDesignState {}

class GetProductSizesSuccessState extends StartDesignState {
  final List sizes;
  final List colors;

  GetProductSizesSuccessState({required this.sizes, required this.colors});
}

class GetProductSizesErrorState extends StartDesignState {
  final String error;

  GetProductSizesErrorState({required this.error});
}

final class ChangeNumberState extends StartDesignState {
  final int number;

  ChangeNumberState(this.number);
}

class ImagePickedState extends StartDesignState {
  final File imageFile;

  ImagePickedState(this.imageFile);
}
final class AddCartItemLoadingState extends StartDesignState {}

final class AddCartItemSuccessState extends StartDesignState {}

final class AddCartItemErrorState extends StartDesignState {
  final String error;

  AddCartItemErrorState(this.error);
}