import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/localizations/app_localizations.dart';

class AppBarContain extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const AppBarContain({
    super.key,
    required this.title,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).translate(title),
      ),
    );
  }
}
