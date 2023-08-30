import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final KeyValueStorageService keyValueStorageService;

  SettingsCubit({
    required this.keyValueStorageService,
  }) : super(const SettingsState()) {
    getSettingsByPrefs();
  }

  void getSettingsByPrefs() {
    String? selectedTheme = keyValueStorageService.getValue<String>('theme');
    String? selectedLanguage =
        keyValueStorageService.getValue<String>('language');

    emit(
      state.copyWith(
        themeMode: selectedTheme != null
            ? ThemeMode.values.byName(selectedTheme)
            : state.themeMode,
        language: selectedLanguage ?? state.language,
      ),
    );
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

  void setLanguage(String language) async {
    if (state.language == language) return;

    await keyValueStorageService.setKeyValue('language', language);

    Locale(language);

    emit(
      state.copyWith(
        language: language,
      ),
    );
  }
}
