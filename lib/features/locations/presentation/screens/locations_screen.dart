import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationsBloc, LocationsState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty && !state.isLoading) {
          SharedUtils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
          final locations = state.locations;
          final isLoading = state.isLoading;
          final errorLoading = state.errorMessage.isNotEmpty;

          return Scaffold(
            appBar: locations.isEmpty
                ? const AppBarContain(
                    title: 'locations',
                  )
                : null,
            body: ScaffoldBodyList(
              elements: locations,
              isLoading: isLoading,
              loadingMessage: 'loading_locations',
              emptyMessage: 'no_locations_loaded',
            ),
            floatingActionButton:
                errorLoading && !isLoading && locations.isEmpty
                    ? FloatingActionButton(
                        onPressed: context.read<LocationsBloc>().loadNextPage,
                        child: const Icon(
                          Icons.refresh,
                        ),
                      )
                    : null,
          );
        },
      ),
    );
  }
}
