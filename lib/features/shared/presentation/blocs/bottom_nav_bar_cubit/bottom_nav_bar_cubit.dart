import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit()
      : super(
          BottomNavBarState(
            episodesController: ScrollController(),
            favoritesController: ScrollController(),
          ),
        );

  void show() {
    if (!state.isVisible) {
      emit(
        state.copyWith(
          isVisible: true,
        ),
      );
    }
  }

  void showAfterRemoveFavorite() {
    if (state.currentIndex != 1 || state.isVisible) return;

    emit(
      state.copyWith(
        isVisible: true,
        favoritesPosition: 0.0,
      ),
    );
  }

  double getCurrentPosition() {
    switch (state.currentIndex) {
      case 0:
        return state.episodesPosition;
      case 1:
        return state.favoritesPosition;
      default:
        return 0.0;
    }
  }

  void hide() {
    double position = getCurrentPosition();
    if (position < state.appBarHeight) return;
    if (state.isVisible) {
      emit(
        state.copyWith(
          isVisible: false,
        ),
      );
    }
  }

  void setCurrentPosition(double position) {
    switch (state.currentIndex) {
      case 0:
        emit(
          state.copyWith(
            episodesPosition: position,
          ),
        );
        break;
      case 1:
        emit(
          state.copyWith(
            favoritesPosition: position,
          ),
        );
        break;
      default:
        throw UnimplementedError(
            'No existe la implementación para este index ${state.currentIndex}');
    }
  }

  void setScrollPosition(double position, ScrollDirection direction) {
    if (direction == ScrollDirection.forward ||
        direction == ScrollDirection.idle) {
      if (position < state.appBarHeight) {
        if (position == 0.0) {
          setCurrentPosition(position);
        }
      } else {
        setCurrentPosition(position);
      }
    } else {
      if (position > state.appBarHeight) setCurrentPosition(position);
    }
  }

  void setCurrentIndex(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
      ),
    );
  }

  void setAppBarHeight(double height) {
    emit(
      state.copyWith(
        appBarHeight: height,
      ),
    );
  }
}
