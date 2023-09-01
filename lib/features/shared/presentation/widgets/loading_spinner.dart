import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/config.dart';

class LoadingSpinner extends StatelessWidget {
  final String message;

  const LoadingSpinner({
    super.key,
    this.message = 'loading',
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
            AppLocalizations.of(context).translate(message),
          ),
        ],
      ),
    );
  }
}
