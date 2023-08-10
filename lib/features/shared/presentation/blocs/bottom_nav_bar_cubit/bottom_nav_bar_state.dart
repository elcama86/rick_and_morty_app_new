part of 'bottom_nav_bar_cubit.dart';

class BottomNavBarState {
  final int currentIndex;
  final bool isVisible;
  final double appBarHeight;
  final Map<int, double> scrollPositions;

  const BottomNavBarState({
    this.currentIndex = 0,
    this.isVisible = true,
    this.appBarHeight = kToolbarHeight,
    this.scrollPositions = const {},
  });

  BottomNavBarState copyWith({
    int? currentIndex,
    bool? isVisible,
    double? appBarHeight,
    Map<int, double>? scrollPositions,
  }) =>
      BottomNavBarState(
        currentIndex: currentIndex ?? this.currentIndex,
        isVisible: isVisible ?? this.isVisible,
        appBarHeight: appBarHeight ?? this.appBarHeight,
        scrollPositions: scrollPositions ?? this.scrollPositions,
      );
}
