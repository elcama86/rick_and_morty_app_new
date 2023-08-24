import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setTheme(ThemeMode themeMode) {
    emit(
      state.copyWith(
        themeMode: themeMode,
      ),
    );
  }
}
