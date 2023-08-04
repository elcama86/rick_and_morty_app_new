import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final controller = ScrollController();

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextFavorites();
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        return;
      }

      if ((controller.position.pixels + 100) >=
          controller.position.maxScrollExtent) {
        loadNextFavorites();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void loadNextFavorites() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    final episodes =
        await context.read<FavoritesEpisodesBloc>().loadFavoritesEpisodes();

    isLoading = false;

    if (episodes.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesEpisodesBloc, FavoritesEpisodesState>(
        builder: (context, state) {
          final List<Episode> favoritesEpisodes =
              state.favoritesEpisodes.values.toList();

          if (favoritesEpisodes.isEmpty) {
            if (isLoading) {
              return const LoadingSpinner();
            }
            return const CustomMessage(
                message: "No existen episodios favoritos");
          }

          final appBarTitleTheme = Theme.of(context).appBarTheme.titleTextStyle;

          return CustomScrollView(
            controller: controller,
            slivers: [
               SliverAppBar(
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Favoritos",
                    style: appBarTitleTheme,
                  ),
                ),
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              ElementsMansory(
                elements: favoritesEpisodes,
              ),
            ],
          );
        },
      ),
    );
  }
}
