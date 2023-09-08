import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({
    super.key,
  });

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<EpisodesView> {
  @override
  void initState() {
    super.initState();
    final episodesState = context.read<EpisodesBloc>().state;
    if (episodesState.episodes.isEmpty && episodesState.errorMessage.isEmpty) {
      context.read<EpisodesBloc>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EpisodesBloc, EpisodesState>(
      bloc: BlocProvider.of<EpisodesBloc>(context),
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty && !state.isLoading) {
          SharedUtils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<EpisodesBloc, EpisodesState>(
        bloc: BlocProvider.of<EpisodesBloc>(context),
        builder: (context, state) {
          if (state.isLoading && state.episodes.isEmpty) {
            return const LoadingSpinner(
              message: 'loading_episodes',
            );
          }

          if (state.episodes.isEmpty) {
            return const CustomMessage(
              message: "no_episodes_loaded",
            );
          }

          return _EpisodesViewContain(
            episodes: state.episodes,
            loadNextPage: context.read<EpisodesBloc>().loadNextPage,
          );
        },
      ),
    );
  }
}

class _EpisodesViewContain extends StatelessWidget {
  final List<Episode> episodes;
  final VoidCallback? loadNextPage;

  const _EpisodesViewContain({
    required this.episodes,
    required this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return ElementsScrollView(
      controller: context.watch<BottomNavBarCubit>().state.episodesController,
      elements: episodes,
      title: "episodes",
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        FadeIn(
          child: IconButton(
            onPressed: () {
              final searchEpisodesState =
                  context.read<SearchEpisodesBloc>().state;

              final searchEpisodes =
                  context.read<SearchEpisodesBloc>().searchEpisodesByQuery;

              showSearch<Episode?>(
                query: searchEpisodesState.query,
                context: context,
                delegate: SearchElementsDelegate(
                  searchElements: searchEpisodes,
                  initialElements: searchEpisodesState.results,
                  label:
                      AppLocalizations.of(context).translate('search_episode'),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ],
      loadNextPage: loadNextPage,
      showBottomNavBar: context.read<BottomNavBarCubit>().show,
      hideBottomNavBar: context.read<BottomNavBarCubit>().hide,
      showContain: context.select(
        (BottomNavBarCubit navBarCubit) => navBarCubit.state.currentIndex == 0,
      ),
      setScrollPosition: context.read<BottomNavBarCubit>().setScrollPosition,
    );
  }
}
