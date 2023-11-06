import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/config.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final appBarTitleTheme = Theme.of(context).appBarTheme.titleTextStyle;

    return SliverAppBar(
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          AppLocalizations.of(context).translate(title),
          style: appBarTitleTheme,
        ),
      ),
      leading: leading,
      actions: actions,
    );
  }
}
