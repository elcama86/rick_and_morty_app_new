import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class EpisodesScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  const EpisodesScreen({
    Key? key,
    required this.navigationShell,
    required this.children,
  }) : super(key: key ?? const ValueKey<String>('EpisodesScreen'));

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
      default:
        appBar = null;
        break;
    }

    return BlocProvider(
      create: (_) => BottomNavBarCubit(),
      child: Scaffold(
        appBar: appBar,
        body: AnimatedBranchContainer(
          currentIndex: index,
          children: children,
        ),
        bottomNavigationBar: CustomBottomNavigation(
          index: index,
          onItemTapped: _goBranch,
        ),
      ),
    );
  }
}

class AnimatedBranchContainer extends StatefulWidget {
  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  const AnimatedBranchContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  @override
  State<AnimatedBranchContainer> createState() =>
      _AnimatedBranchContainerState();
}

class _AnimatedBranchContainerState extends State<AnimatedBranchContainer> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.currentIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }

    return PageView(
      //* Esto evita que rebote
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: widget.children,
    );
  }
}
