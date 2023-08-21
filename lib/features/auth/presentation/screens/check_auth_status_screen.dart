import 'package:flutter/material.dart';
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
        return 'Iniciando...';
      case AuthStatus.loading:
        return 'Cerrando sesión...';
      default:
        return 'Cargando...';
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
              message(status),
            ),
          ],
        ),
      ),
    );
  }
}
