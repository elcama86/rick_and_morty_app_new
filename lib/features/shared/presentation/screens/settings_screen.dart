import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('settings'),
        ),
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
        Divider(),
        _FavoritesSettings(),
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
        final selectedLanguage =
            state.isSystemLanguage ? 'system_language' : state.language;

        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: Text(
                AppLocalizations.of(context).translate('language'),
                style: textThemes.titleMedium,
              ),
            ),
            ...languages
                .map(
                  (language) => RadioListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 24.0),
                    title: Text(
                      AppLocalizations.of(context).translate(language.name),
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
            RadioListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              title: Text(
                AppLocalizations.of(context).translate('system_language'),
                style: textThemes.titleSmall,
              ),
              value: 'system_language',
              groupValue: selectedLanguage,
              onChanged: (_) => context
                  .read<SettingsCubit>()
                  .setSystemLanguage(selectedLanguage),
              controlAffinity: controlAffinity,
            ),
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

class _FavoritesSettings extends StatelessWidget {
  const _FavoritesSettings();

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<FavoritesEpisodesBloc, FavoritesEpisodesState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(
                AppLocalizations.of(context).translate('favorites'),
                style: textThemes.titleMedium,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 40.0),
              title: Text(
                AppLocalizations.of(context).translate('selected_favorites'),
                style: textThemes.titleSmall,
              ),
              trailing: Text(
                '${state.totalFavorites}',
                style: textThemes.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: colors.error,
                textStyle: textThemes.titleSmall,
              ),
              onPressed: state.totalFavorites > 0
                  ? () => SharedUtils.showAlertDialog(
                        context: context,
                        title: 'attention',
                        message: 'confirm_delete_favorites_message',
                        acceptAction: context
                            .read<FavoritesEpisodesBloc>()
                            .clearEpisodesDb,
                        iconColor: colors.error,
                        acceptButtonColor: colors.error,
                      )
                  : null,
              icon: const Icon(Icons.delete_forever),
              label: Text(
                AppLocalizations.of(context).translate('delete_favorites'),
               
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        );
      },
    );
  }
}
