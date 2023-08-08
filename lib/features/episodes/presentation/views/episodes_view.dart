import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
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
    if (episodesState.episodes.isEmpty) {
      context.read<EpisodesBloc>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EpisodesBloc, EpisodesState>(
      bloc: BlocProvider.of<EpisodesBloc>(context),
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty && !state.isLoading) {
          Utils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<EpisodesBloc, EpisodesState>(
        bloc: BlocProvider.of<EpisodesBloc>(context),
        builder: (context, state) {
          if (state.isLoading && state.episodes.isEmpty) {
            return const LoadingSpinner();
          }

          if (state.episodes.isEmpty) {
            return const CustomMessage(
              message: "No existen episodios cargados",
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

class _EpisodesViewContain extends StatefulWidget {
  final List<Episode> episodes;
  final VoidCallback? loadNextPage;

  const _EpisodesViewContain({
    required this.episodes,
    required this.loadNextPage,
  });

  @override
  State<_EpisodesViewContain> createState() => _EpisodesViewContainState();
}

class _EpisodesViewContainState extends State<_EpisodesViewContain> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (widget.loadNextPage == null) return;
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        context.read<BottomNavBarCubit>().show();
        return;
      }

      context.read<BottomNavBarCubit>().hide();

      if ((controller.position.pixels + 100) >=
          controller.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitleTheme = Theme.of(context).appBarTheme.titleTextStyle;

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Episodios",
              style: appBarTitleTheme,
            ),
          ),
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
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ],
        ),
        ElementsMansory(
          elements: widget.episodes,
        ),
      ],
    );
  }
}
