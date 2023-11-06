import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';

import 'package:rick_and_morty_app/features/shared/shared.dart';

import '../../domain/entities/location.dart';
import '../blocs/blocs.dart';

class LocationsView extends StatefulWidget {
  final List<Location> locations;

  const LocationsView({
    super.key,
    required this.locations,
  });

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElementsScrollView(
      controller: controller,
      elements: widget.locations,
      title: 'locations',
      actions: [
        FadeIn(
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final searchLocationsState =
                  context.read<SearchLocationsBloc>().state;

              final searchLocations =
                  context.read<SearchLocationsBloc>().searchLocationsByQuery;
                  
              showSearch<Location?>(
                query: searchLocationsState.query,
                context: context,
                delegate: SearchElementsDelegate(
                  searchElements: searchLocations,
                  initialElements: searchLocationsState.results,
                  label:
                      AppLocalizations.of(context).translate('search_location'),
                ),
              );
            },
          ),
        ),
      ],
      loadNextPage: context.read<LocationsBloc>().loadNextPage,
    );
  }
}
