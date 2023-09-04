import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class CustomMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  const CustomMessage({
    super.key,
    required this.message,
    this.icon = Icons.info,
  });

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              message.contains(',')
                  ? SharedUtils.specialTranslate(message, context)
                  : AppLocalizations.of(context).translate(message),
              textAlign: TextAlign.center,
              style: textThemes.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
