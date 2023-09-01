import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class FavoritesEpisodesView extends StatefulWidget {
  const FavoritesEpisodesView({super.key});

  @override
  State<FavoritesEpisodesView> createState() => _FavoritesEpisodesViewState();
}

class _FavoritesEpisodesViewState extends State<FavoritesEpisodesView> {
  late ScrollController controller;

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextFavorites();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void loadNextFavorites() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        final episodes =
            await context.read<FavoritesEpisodesBloc>().loadFavoritesEpisodes();

        isLoading = false;

        if (episodes.isEmpty) {
          isLastPage = true;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesEpisodesBloc, FavoritesEpisodesState>(
      builder: (context, state) {
        final List<Episode> favoritesEpisodes =
            state.favoritesEpisodes.values.toList();

        if (isLoading && favoritesEpisodes.isEmpty && state.isFirstLoad) {
          return const _LoadingFavorites();
        }

        if (favoritesEpisodes.isEmpty) {
          isLastPage = false;
          return const _NoFavorites();
        }

        return ElementsScrollView(
          controller: controller,
          elements: favoritesEpisodes,
          title: "favorites",
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          loadNextPage: loadNextFavorites,
          showBottomNavBar: context.read<BottomNavBarCubit>().show,
          hideBottomNavBar: context.read<BottomNavBarCubit>().hide,
          setScrollPositions:
              context.read<BottomNavBarCubit>().setScrollPositions,
        );
      },
    );
  }
}

class _NoFavorites extends StatelessWidget {
  const _NoFavorites();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('favorites'),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const CustomMessage(
        message: "no_favorites_loaded",
      ),
    );
  }
}

class _LoadingFavorites extends StatelessWidget {
  const _LoadingFavorites();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('favorites'),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const LoadingSpinner(
        message: 'loading_favorites',
      ),
    );
  }
}
