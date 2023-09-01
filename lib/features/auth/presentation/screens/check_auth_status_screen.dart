import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/localizations/app_localizations.dart';
import 'package:rick_and_morty_app/features/auth/presentation/presentation.dart';

class CheckAuthStatusScreen extends StatelessWidget {
  final AuthStatus status;

  const CheckAuthStatusScreen({
    super.key,
    required this.status,
  });

  String message(AuthStatus status) {
    switch (status) {
      case AuthStatus.checking:
        return 'starting';
      case AuthStatus.loading:
        return 'closing_sesion';
      default:
        return 'loading';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              AppLocalizations.of(context).translate(message(status)),
            ),
          ],
        ),
      ),
    );
  }
}
