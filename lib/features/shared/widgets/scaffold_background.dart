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
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            child: Container(
              color: backgroundColor,
            ),
          ),
          // Background with image
          Container(
            height: size.height,
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                opacity: 0.4,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.jpg'),
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
