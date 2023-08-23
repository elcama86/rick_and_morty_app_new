import 'package:flutter/material.dart';

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
      ],
    );
  }
}

class _ThemeSettings extends StatelessWidget {
  const _ThemeSettings();

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

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
          value: false,
          onChanged: null,
          secondary: const Icon(Icons.light_mode_outlined),
        ),
        SwitchListTile(
          title: Text(
            'Tema Oscuro',
            style: textThemes.titleSmall,
          ),
          value: false,
          onChanged: null,
          secondary: const Icon(Icons.dark_mode_outlined),
        ),
        SwitchListTile(
          title: Text(
            'Tema predeterminado por sistema',
            style: textThemes.titleSmall,
          ),
          value: false,
          onChanged: null,
          secondary: const Icon(Icons.brightness_medium_outlined),
        ),
      ],
    );
  }
}
