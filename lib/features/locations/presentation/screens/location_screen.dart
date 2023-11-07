import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    super.key,
    required this.locationId,
    required this.locationName,
  });

  final String locationId;
  final String locationName;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().getLocation(widget.locationId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty &&
            state.locationsMap[widget.locationId] == null) {
          SharedUtils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          final location = state.locationsMap[widget.locationId];
          final errorMessage = state.errorMessage;

          return ElementScaffoldScreen(
            appBarTitle: widget.locationName,
            element: location,
            id: widget.locationId,
            hasError: errorMessage.isNotEmpty,
          );
        },
      ),
    );
  }
}
