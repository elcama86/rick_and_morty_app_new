import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/presentation/delegates/search_elements_delegate.dart';
import 'package:rick_and_morty_app/features/shared/presentation/widgets/widgets.dart';

class EpisodesView extends StatefulWidget {
  final List<Episode> episodes;
  final VoidCallback? loadNextPage;

  const EpisodesView({
    super.key,
    required this.episodes,
    this.loadNextPage,
  });

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<EpisodesView> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (widget.loadNextPage == null) return;
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        return;
      }

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
