import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class TitleSliverAppBar extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final Color gradientColor;

  const TitleSliverAppBar({
    super.key,
    required this.title,
    required this.textStyle,
    required this.gradientColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.5, 1.0],
          colors: [
            Colors.transparent,
            gradientColor,
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Text(
                  title,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
