import 'package:flutter/material.dart';

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
            message,
            textAlign: TextAlign.center,
            style: textThemes.titleMedium,
          ),
        ],
      ),
    );
  }
}
