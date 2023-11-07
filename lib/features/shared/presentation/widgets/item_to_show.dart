import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/localizations/app_localizations.dart';

class ItemToShow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const ItemToShow({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
            )
          : const SizedBox(),
      title: Text(
        AppLocalizations.of(context).translate(title),
        style: textThemes.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: textThemes.titleSmall,
      ),
    );
  }
}
