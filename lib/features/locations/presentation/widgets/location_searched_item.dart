import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';

class LocationSearchedItem extends StatelessWidget {
  final Location location;

  const LocationSearchedItem({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: GestureDetector(
        onTap: () => context.push(
          Uri(
            path: '/locations/location',
            queryParameters: {
              'id': '${location.id}',
              'name': location.name,
            },
          ).toString(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            children: [
              LocationCard(
                location: location,
              ),
              const SizedBox(
                height: 10.0,
              ),
              _LocationDetails(
                location: location,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationDetails extends StatelessWidget {
  final Location location;

  const _LocationDetails({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final type = AppLocalizations.of(context)
        .translate(LocationUtils.getType(location.type));
    final dimension =
        AppLocalizations.of(context).translate(location.dimension);

    return SizedBox(
      width: size.width * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.flag),
            title: Text(
              type.isEmpty ? location.type : type,
              style: textStyles.titleSmall,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: Text(
              dimension.isEmpty ? location.dimension : dimension,
              style: textStyles.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
