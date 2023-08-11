import 'package:flutter/material.dart';

class ScaffoldBackground extends StatelessWidget {
  final Widget child;
  const ScaffoldBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox.expand(
      child: Stack(
        children: [
          // Background with image
          Container(
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.4,
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.png'),
              ),
            ),
          ),
          // Child widget
          child,
        ],
      ),
    );
  }
}
