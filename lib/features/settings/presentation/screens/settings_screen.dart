import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/config.dart';

import '../views/settings_view.dart';



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
      body: const SettingsView(),
    );
  }
}