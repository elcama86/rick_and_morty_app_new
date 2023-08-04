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
    final index = navigationShell.currentIndex;

    late PreferredSizeWidget? appBar;

    switch (index) {
      case 0:
        appBar = context.select(
          (EpisodesBloc episodesBloc) =>
              Utils.appBarContain(episodesBloc.state.episodes, "Episodios"),
        );
        break;
      case 1:
        appBar = context.select(
          (FavoritesEpisodesBloc favoritesEpisodesBloc) => Utils.appBarContain(
              favoritesEpisodesBloc.state.favoritesEpisodes.values.toList(),
              "Favoritos"),
        );
        break;
      default:
        appBar = null;
        break;
    }

    return Scaffold(
      appBar: appBar,
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigation(
        index: index,
        onItemTapped: _goBranch,
      ),
    );
  }
}
