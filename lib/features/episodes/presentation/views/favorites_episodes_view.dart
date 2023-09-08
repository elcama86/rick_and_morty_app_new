import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class FavoritesEpisodesView extends StatefulWidget {
  const FavoritesEpisodesView({super.key});

  @override
  State<FavoritesEpisodesView> createState() => _FavoritesEpisodesViewState();
}

class _FavoritesEpisodesViewState extends State<FavoritesEpisodesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextFavorites();
  }

  @override
  void dispose() {
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
          return const LoadingSpinner(
            message: 'loading_favorites',
          );
        }

        if (favoritesEpisodes.isEmpty) {
          isLastPage = false;
          return const CustomMessage(
            message: "no_favorites_loaded",
          );
        }

        return ElementsScrollView(
          controller:
              context.watch<BottomNavBarCubit>().state.favoritesController,
          elements: favoritesEpisodes,
          title: "favorites",
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          loadNextPage: loadNextFavorites,
          showBottomNavBar: context.read<BottomNavBarCubit>().show,
          hideBottomNavBar: context.read<BottomNavBarCubit>().hide,
          showContain: context.select(
            (BottomNavBarCubit navBarCubit) =>
                navBarCubit.state.currentIndex == 1,
          ),
          setScrollPosition:
              context.read<BottomNavBarCubit>().setScrollPosition,
        );
      },
    );
  }
}
