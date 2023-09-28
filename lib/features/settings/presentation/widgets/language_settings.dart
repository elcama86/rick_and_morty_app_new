import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';

import '../blocs/blocs.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});

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
