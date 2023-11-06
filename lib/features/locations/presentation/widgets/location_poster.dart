import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';

class LocationPoster extends StatelessWidget {
  final Location location;

  const LocationPoster({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final random = Random();

    return FadeInUp(
      from: random.nextInt(100) + 70,
      delay: Duration(milliseconds: random.nextInt(350)),
      child: Column(
        children: [
          LocationCard(
            location: location,
          ),
          const SizedBox(
            height: 10.0,
          ),
          CircleAvatar(
            child: Text(
              location.id.toString(),
              style: textStyles.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}