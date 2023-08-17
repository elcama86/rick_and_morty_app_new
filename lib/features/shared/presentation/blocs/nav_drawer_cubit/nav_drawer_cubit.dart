import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_drawer_state.dart';

class NavDrawerCubit extends Cubit<NavDrawerState> {
  NavDrawerCubit() : super(const NavDrawerState());

  void setCurrentIndex(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
      ),
    );
  }
}
