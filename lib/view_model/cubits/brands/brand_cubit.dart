import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  final CarouselSliderController carouselController = CarouselSliderController();

  late final ScrollController scrollController;

  BrandCubit()
      : super(const BrandInitial(currentIndex: 0, isAppBarVisible: true, isAtTop: false)) {
    scrollController = ScrollController()..addListener(_handleScroll);
  }

  static BrandCubit get(context) => BlocProvider.of(context);
  final List<String> brands = List.generate(
    17,
        (index) => 'assets/images/brand${index + 1}.jpeg',
  );
  // Handle carousel logic
  void previousPage() {
    int newIndex = state.currentIndex == 0 ? brands.length - 1 : state.currentIndex - 1;
    emit(state.copyWith(currentIndex: newIndex));
    carouselController.animateToPage(newIndex);
  }

  void nextPage() {
    int newIndex = state.currentIndex == brands.length - 1 ? 0 : state.currentIndex + 1;
    emit(state.copyWith(currentIndex: newIndex));
    carouselController.animateToPage(newIndex);
  }

  void setPage(int index) {
    if (index >= 0 && index < brands.length) {
      emit(state.copyWith(currentIndex: index));
      carouselController.animateToPage(index);
    }
  }

  // Handle scroll-related logic
  void _handleScroll() {
    if (!scrollController.hasClients) return; // Prevents calling before initialization

    final offset = scrollController.offset;
    final direction = scrollController.position.userScrollDirection;

    if (offset == 0) {
      // Ensure the AppBar is visible when at the top of the list
      emit(state.copyWith(isAppBarVisible: true, isAtTop: false));
      return;
    }

    if (direction == ScrollDirection.reverse && state.isAppBarVisible) {
      emit(state.copyWith(isAppBarVisible: false));
    } else if (direction == ScrollDirection.forward && !state.isAppBarVisible) {
      emit(state.copyWith(isAppBarVisible: true));
    }

    if (offset >= 10.h && !state.isAtTop) {
      emit(state.copyWith(isAtTop: true));
    } else if (offset < 10.h && state.isAtTop) {
      emit(state.copyWith(isAtTop: false));
    }
  }


  @override
  Future<void> close() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    return super.close();
  }
}
