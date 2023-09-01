part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final String language;
  final bool isSystemLanguage;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.language = 'en',
    this.isSystemLanguage = true,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? language,
    bool? isSystemLanguage,
  }) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        language: language ?? this.language,
        isSystemLanguage: isSystemLanguage ?? this.isSystemLanguage,
      );

  @override
  List<Object> get props => [themeMode, language, isSystemLanguage];
}
