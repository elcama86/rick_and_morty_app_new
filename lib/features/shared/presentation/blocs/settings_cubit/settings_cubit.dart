import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/shared/infrastructure/services/key_value_storage_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final KeyValueStorageService keyValueStorageService;

  SettingsCubit({
    required this.keyValueStorageService,
  }) : super(const SettingsState()) {
    getThemeByPrefs();
  }

  void getThemeByPrefs() {
    String? themeSelected = keyValueStorageService.getValue<String>('theme');

    if (themeSelected != null) {
      final themeMode = ThemeMode.values.byName(themeSelected);

      emit(
        state.copyWith(
          themeMode: themeMode,
        ),
      );
    }
  }

  void setTheme(ThemeMode themeMode) async {
    if (state.themeMode == themeMode) return;

    await keyValueStorageService.setKeyValue('theme', themeMode.name);

    emit(
      state.copyWith(
        themeMode: themeMode,
      ),
    );
  }
}
