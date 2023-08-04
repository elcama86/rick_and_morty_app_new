import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class EpisodesScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const EpisodesScreen({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodesBloc, EpisodesState>(
      bloc: BlocProvider.of<EpisodesBloc>(context),
      builder: (context, state) {
        return Scaffold(
          appBar: Utils.appBarContain(state.episodes, "Episodios"),
          body: navigationShell,
          bottomNavigationBar: CustomBottomNavigation(
            index: navigationShell.currentIndex,
            onItemTapped: _goBranch,
          ),
        );
      },
    );
  }
}
