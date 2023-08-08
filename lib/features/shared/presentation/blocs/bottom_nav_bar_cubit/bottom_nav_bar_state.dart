part of 'bottom_nav_bar_cubit.dart';

class BottomNavBarState extends Equatable {
  final bool isVisible;

  const BottomNavBarState({
    this.isVisible = true,
  });

  BottomNavBarState copyWith({
    bool? isVisible,
  }) =>
      BottomNavBarState(
        isVisible: isVisible ?? this.isVisible,
      );

  @override
  List<Object> get props => [isVisible];
}
