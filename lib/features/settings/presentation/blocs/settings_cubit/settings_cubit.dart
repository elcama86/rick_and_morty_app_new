import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final KeyValueStorageService keyValueStorageService;
  late final StreamSubscription<String> _languageSubscription;

  SettingsCubit({
    required this.keyValueStorageService,
  }) : super(const SettingsState()) {
    setSettingsByPrefs();
  }

  void setSettingsByPrefs() {
    String? selectedTheme = keyValueStorageService.getValue<String>('theme');
    String? selectedLanguage =
        keyValueStorageService.getValue<String>('language');
    bool? isSystemLanguage =
        keyValueStorageService.getValue<bool>('isSystemLanguage');

    emit(
      state.copyWith(
        themeMode: selectedTheme != null
            ? ThemeMode.values.byName(selectedTheme)
            : state.themeMode,
        language: selectedLanguage ?? state.language,
        isSystemLanguage: isSystemLanguage ?? state.isSystemLanguage,
      ),
    );

    _languageSubscription = AppLocalizations.language.stream.listen((language) {
      if (state.isSystemLanguage) {
        emit(
          state.copyWith(
            language: language,
          ),
        );
      }
    });
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
    if (state.language == language && !state.isSystemLanguage) return;

    await keyValueStorageService.setKeyValue('language', language);
    await keyValueStorageService.setKeyValue('isSystemLanguage', false);

    emit(
      state.copyWith(
        language: language,
        isSystemLanguage: false,
      ),
    );
  }

  void setSystemLanguage(String language) async {
    if (language == 'system_value') return;

    await keyValueStorageService.setKeyValue('isSystemLanguage', true);

    emit(
      state.copyWith(
        isSystemLanguage: true,
      ),
    );
  }

  @override
  Future<void> close() {
    _languageSubscription.cancel();
    return super.close();
  }
}
