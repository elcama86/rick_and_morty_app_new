import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      children: const [
        ThemeSettings(),
        Divider(),
        LanguageSettings(),
        Divider(),
        FavoritesSettings(),
      ],
    );
  }
}
