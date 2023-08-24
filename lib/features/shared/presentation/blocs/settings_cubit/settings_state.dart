part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;

  const SettingsState({
    this.themeMode = ThemeMode.system,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
  }) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
      );

  @override
  List<Object> get props => [themeMode];
}
