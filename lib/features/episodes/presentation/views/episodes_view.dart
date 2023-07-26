import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

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
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        SliverList.builder(
          itemCount: widget.episodes.length,
          itemBuilder: (context, index) {
            return EpisodeCard(
              episode: widget.episodes[index],
            );
          },
        ),
      ],
    );
  }
}
