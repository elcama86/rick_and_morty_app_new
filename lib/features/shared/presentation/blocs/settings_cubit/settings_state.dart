part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final String language;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.language = 'es',
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? language,
  }) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        language: language ?? this.language,
      );

  @override
  List<Object> get props => [themeMode, language];
}
