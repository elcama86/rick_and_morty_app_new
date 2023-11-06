import 'package:flutter/material.dart';

import '../../domain/entities/location.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      height: 180.0,
      width: size.width * 0.3,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: colors.surfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          side: BorderSide(
            color: colors.outline,
          ),
        ),
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  location.name,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: textStyles.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
