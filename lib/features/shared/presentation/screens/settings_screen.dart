import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      children: const [
        _ThemeSettings(),
        Divider(),
        _LanguageSettings(),
      ],
    );
  }
}

class _LanguageSettings extends StatelessWidget {
  const _LanguageSettings();

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    const controlAffinity = ListTileControlAffinity.trailing;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final selectedLanguage = state.language;

        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: Text(
                'Idioma',
                style: textThemes.titleMedium,
              ),
            ),
            ...languages
                .map(
                  (language) => RadioListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 24.0),
                    title: Text(
                      language.name,
                      style: textThemes.titleSmall,
                    ),
                    value: language.languageCode,
                    groupValue: selectedLanguage,
                    onChanged: (value) =>
                        context.read<SettingsCubit>().setLanguage(value!),
                    controlAffinity: controlAffinity,
                  ),
                )
                .toList(),
          ],
        );
      },
    );
  }
}

class _ThemeSettings extends StatelessWidget {
  const _ThemeSettings();

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final lightValue = state.themeMode == ThemeMode.light;
        final darkValue = state.themeMode == ThemeMode.dark;
        final systemValue = state.themeMode == ThemeMode.system;

        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.palette_rounded),
              title: Text(
                'Tema establecido',
                style: textThemes.titleMedium,
              ),
            ),
            SwitchListTile(
              title: Text(
                'Tema claro',
                style: textThemes.titleSmall,
              ),
              value: lightValue,
              onChanged: (_) =>
                  context.read<SettingsCubit>().setTheme(ThemeMode.light),
              secondary: Icon(
                lightValue ? Icons.light_mode : Icons.light_mode_outlined,
              ),
            ),
            SwitchListTile(
              title: Text(
                'Tema Oscuro',
                style: textThemes.titleSmall,
              ),
              value: darkValue,
              onChanged: (_) =>
                  context.read<SettingsCubit>().setTheme(ThemeMode.dark),
              secondary: Icon(
                darkValue ? Icons.dark_mode : Icons.dark_mode_outlined,
              ),
            ),
            SwitchListTile(
              title: Text(
                'Tema predeterminado por sistema',
                style: textThemes.titleSmall,
              ),
              value: systemValue,
              onChanged: (_) =>
                  context.read<SettingsCubit>().setTheme(ThemeMode.system),
              secondary: Icon(
                systemValue
                    ? Icons.brightness_medium
                    : Icons.brightness_medium_outlined,
              ),
            ),
          ],
        );
      },
    );
  }
}
