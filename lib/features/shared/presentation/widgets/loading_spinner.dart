import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final String message;

  const LoadingSpinner({
    super.key,
    this.message = 'Cargando...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
            message,
          ),
        ],
      ),
    );
  }
}
