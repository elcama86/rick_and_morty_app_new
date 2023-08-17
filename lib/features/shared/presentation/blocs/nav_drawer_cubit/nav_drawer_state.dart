part of 'nav_drawer_cubit.dart';

class NavDrawerState extends Equatable {
  final int currentIndex;

  const NavDrawerState({
    this.currentIndex = 0,
  });

  NavDrawerState copyWith({
    int? currentIndex,
  }) =>
      NavDrawerState(
        currentIndex: currentIndex ?? this.currentIndex,
      );

  @override
  List<Object> get props => [currentIndex];
}
