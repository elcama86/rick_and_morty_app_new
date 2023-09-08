part of 'bottom_nav_bar_cubit.dart';

class BottomNavBarState extends Equatable {
  final int currentIndex;
  final bool isVisible;
  final double appBarHeight;
  final ScrollController episodesController;
  final ScrollController favoritesController;
  final double episodesPosition;
  final double favoritesPosition;

  const BottomNavBarState({
    this.currentIndex = 0,
    this.isVisible = true,
    this.appBarHeight = kToolbarHeight,
    required this.episodesController,
    required this.favoritesController,
    this.episodesPosition = 0.0,
    this.favoritesPosition = 0.0,
  });

  BottomNavBarState copyWith({
    int? currentIndex,
    bool? isVisible,
    double? appBarHeight,
    ScrollController? episodesController,
    ScrollController? favoritesController,
    double? episodesPosition,
    double? favoritesPosition,
  }) =>
      BottomNavBarState(
        currentIndex: currentIndex ?? this.currentIndex,
        isVisible: isVisible ?? this.isVisible,
        appBarHeight: appBarHeight ?? this.appBarHeight,
        episodesController: episodesController ?? this.episodesController,
        favoritesController: favoritesController ?? this.favoritesController,
        episodesPosition: episodesPosition ?? this.episodesPosition,
        favoritesPosition: favoritesPosition ?? this.favoritesPosition,
      );

  double get finalPosition {
    switch (currentIndex) {
      case 0:
        return episodesController.hasClients
            ? episodesController.position.pixels
            : 0.0;
      case 1:
        return favoritesController.hasClients
            ? favoritesController.position.pixels
            : 0.0;
      default:
        return 0.0;
    }
  }

  double get currentPosition {
    switch (currentIndex) {
      case 0:
        return episodesPosition;
      case 1:
        return favoritesPosition;
      default:
        return 0.0;
    }
  }

  @override
  List<Object> get props => [
        currentIndex,
        isVisible,
        appBarHeight,
        episodesController,
        favoritesController,
        episodesPosition,
        favoritesPosition,
      ];
}
