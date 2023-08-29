part of 'settings_cubit.dart';

enum LanguageOption {
  spanish,
  english,
}

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final LanguageOption language;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.language = LanguageOption.spanish,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    LanguageOption? language,
  }) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        language: language ?? this.language,
      );

  @override
  List<Object> get props => [themeMode, language];
}
