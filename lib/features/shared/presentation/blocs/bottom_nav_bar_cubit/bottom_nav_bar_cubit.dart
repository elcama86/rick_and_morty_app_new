import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
    if (state.isVisible) {
      emit(
        state.copyWith(
          isVisible: false,
        ),
      );
    }
  }
}
