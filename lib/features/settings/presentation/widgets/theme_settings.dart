import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';

import '../blocs/blocs.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

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
                AppLocalizations.of(context).translate('theme_selected'),
                style: textThemes.titleMedium,
              ),
            ),
            SwitchListTile(
              title: Text(
                AppLocalizations.of(context).translate('light_theme'),
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
                AppLocalizations.of(context).translate('dark_theme'),
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
                AppLocalizations.of(context).translate('system_theme'),
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
