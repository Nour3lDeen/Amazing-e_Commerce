import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/brand_model/brand_model.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/network/dio_helper.dart';
import '../../data/network/endpoints.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  final ScrollController scrollController = ScrollController();

  int currentIndex = 0;
  bool isAppBarVisible = true;
  bool isAtTop = true;

  BrandCubit() : super(BrandInitial()) {
    scrollController.addListener(_handleScroll);
  }

  static BrandCubit get(BuildContext context) =>
      BlocProvider.of<BrandCubit>(context);

  void previousPage() {
    currentIndex =
        (currentIndex == 0) ? brandsList.length - 1 : currentIndex - 1;
    carouselController.animateToPage(currentIndex);
    emit(BrandUpdated());
  }

  void nextPage() {
    currentIndex =
        (currentIndex == brandsList.length - 1) ? 0 : currentIndex + 1;
    carouselController.animateToPage(currentIndex);
    emit(BrandUpdated());
  }

  void setPage(int index) {
    if (index >= 0 && index < brandsList.length) {
      currentIndex = index;
      carouselController.animateToPage(index);
      emit(BrandUpdated());
    }
  }

  void _handleScroll() {
    if (!scrollController.hasClients) return;

    final offset = scrollController.offset;
    final newIsAtTop = offset < 10.h;
    final newIsAppBarVisible = offset == 0 ||
        scrollController.position.userScrollDirection == ScrollDirection.forward;

    // Only emit state when values actually change
    if (isAtTop != newIsAtTop || isAppBarVisible != newIsAppBarVisible) {
      isAtTop = newIsAtTop;
      isAppBarVisible = newIsAppBarVisible;
      emit(BrandUpdated()); // Ensure UI rebuilds
    }
  }

  List<BrandModel> brandsList = [];

  Future<void> getBrands() async {
    debugPrint('Fetching brands...');
    emit(GetBrandsLoadingState());
    try {
      Response response = await DioHelper.get(path: EndPoints.brands);
      if (response.data['statusCode'] == 200 && response.data['data'] != null) {
        brandsList = List<BrandModel>.from(
            (response.data['data'] as List).map((x) => BrandModel.fromJson(x)));
        debugPrint('Brands: ${brandsList.toString()}');
        emit(GetBrandsSuccessState());
      } else {
        emit(GetBrandsFailureState(
          msg: response.data['message'],
        ));
        debugPrint('Error: ${response.data['message']}');
      }
    } on DioException catch (e) {
      emit(
        GetBrandsFailureState(
          msg: e.response!.data['message'],
        ),
      );
      debugPrint('Error: ${e.response!.data['message']}');
    }
  }

  int currentSectionIndex = 0;
  int currentSectionId = 5;

  void changeSection(int index, context) {
    currentSectionIndex = index;
    currentSectionId = ProductsCubit.get(context).sections[index].id!;
    emit(ChangeSectionState());
  }

  int currentCategoryIndex = -1;
  int currentCategoryId = 0;

  void changeCategory(int index, int sectionId, context) {
    if(currentCategoryIndex!= index){
      currentCategoryIndex = index;
      if (index != -1) {
        currentCategoryId = ProductsCubit.get(context)
            .allCategories
            .where((e) => e.sectionId == sectionId)
            .toList()[index]
            .id!;
      }
      emit(ChangeCategoryState(index: index));
    }

  }

  @override
  Future<void> close() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    return super.close();
  }
}
