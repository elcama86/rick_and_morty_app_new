import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(const BottomNavBarState());

  void show() {
    if (!state.isVisible) {
      emit(
        state.copyWith(
          isVisible: true,
        ),
      );
    }
  }

  void hide() {
    double position = state.scrollPositions[state.currentIndex] ?? 0.0;
    if (position < state.appBarHeight) return;
    if (state.isVisible) {
      emit(
        state.copyWith(
          isVisible: false,
        ),
      );
    }
  }

  void checkScrollPosition(double position, ScrollDirection direction) {
    if (direction == ScrollDirection.forward) {
      if (position < state.appBarHeight) {
        if (position == 0.0) {
          state.scrollPositions.update(state.currentIndex, (value) => position);
        }
      } else {
        state.scrollPositions.update(state.currentIndex, (value) => position);
      }
    } else {
      if (position > state.appBarHeight) {
        state.scrollPositions.update(state.currentIndex, (value) => position);
      }
    }
  }

  void setScrollPositions(double position, ScrollDirection direction) {
    if (state.scrollPositions[state.currentIndex] != null) {
      checkScrollPosition(position, direction);

      emit(
        state.copyWith(
          scrollPositions: {...state.scrollPositions},
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        scrollPositions: {
          ...state.scrollPositions,
          state.currentIndex: position
        },
      ),
    );
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
