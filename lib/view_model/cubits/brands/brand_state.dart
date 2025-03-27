part of 'brand_cubit.dart';

abstract class BrandState {
  const BrandState();
}

class BrandInitial extends BrandState {}

class BrandUpdated extends BrandState {}

class GetBrandsLoadingState extends BrandState {}

class GetBrandsSuccessState extends BrandState {}

class GetBrandsFailureState extends BrandState {
  final String msg;

  const GetBrandsFailureState({
    required this.msg,
  });
}

class ChangeSectionState extends BrandState {}

class ChangeCategoryState extends BrandState {
  final int index;

  ChangeCategoryState({required this.index});
}
