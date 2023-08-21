import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class CheckAuthStatusScreen extends StatelessWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingSpinner(),
          SizedBox(
            height: 10.0,
          ),
          Text('Cargando...'),
        ],
      ),
    );
  }
}
