part of 'brand_cubit.dart';

abstract class BrandState {
  final int currentIndex;
  final bool isAppBarVisible;
  final bool isAtTop;

  const BrandState({
    required this.currentIndex,
    required this.isAppBarVisible,
    required this.isAtTop,
  });

  BrandState copyWith({
    int? currentIndex,
    bool? isAppBarVisible,
    bool? isAtTop,
  });
}

class BrandInitial extends BrandState {
  const BrandInitial({
    required super.currentIndex,
    required super.isAppBarVisible,
    required super.isAtTop,
  });

  @override
  BrandState copyWith({
    int? currentIndex,
    bool? isAppBarVisible,
    bool? isAtTop,
  }) {
    return BrandInitial(
      currentIndex: currentIndex ?? this.currentIndex,
      isAppBarVisible: isAppBarVisible ?? this.isAppBarVisible,
      isAtTop: isAtTop ?? this.isAtTop,
    );
  }
}

class BrandUpdated extends BrandState {
  const BrandUpdated({
    required super.currentIndex,
    required super.isAppBarVisible,
    required super.isAtTop,
  });

  @override
  BrandState copyWith({
    int? currentIndex,
    bool? isAppBarVisible,
    bool? isAtTop,
  }) {
    return BrandUpdated(
      currentIndex: currentIndex ?? this.currentIndex,
      isAppBarVisible: isAppBarVisible ?? this.isAppBarVisible,
      isAtTop: isAtTop ?? this.isAtTop,
    );
  }
}
