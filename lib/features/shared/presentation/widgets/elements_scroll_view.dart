import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'elements_mansory.dart';

class ElementsScrollView<T> extends StatefulWidget {
  final ScrollController controller;
  final List<T> elements;
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? loadNextPage;
  final VoidCallback? showBottomNavBar;
  final VoidCallback? hideBottomNavBar;

  const ElementsScrollView({
    super.key,
    required this.controller,
    required this.elements,
    required this.title,
    this.leading,
    this.actions,
    this.loadNextPage,
    this.showBottomNavBar,
    this.hideBottomNavBar,
  });

  @override
  State<ElementsScrollView<T>> createState() => _ElementsScrollViewState<T>();
}

class _ElementsScrollViewState<T> extends State<ElementsScrollView<T>> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    if (widget.loadNextPage == null) return;
    if (widget.controller.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (widget.showBottomNavBar != null) widget.showBottomNavBar!();
      return;
    }

    if (widget.hideBottomNavBar != null) widget.hideBottomNavBar!();

    if ((widget.controller.position.pixels + 100) >=
        widget.controller.position.maxScrollExtent) {
      widget.loadNextPage!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitleTheme = Theme.of(context).appBarTheme.titleTextStyle;

    return CustomScrollView(
      controller: widget.controller,
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.title,
              style: appBarTitleTheme,
            ),
          ),
          leading: widget.leading,
          actions: widget.actions,
        ),
        ElementsMansory(
          elements: widget.elements,
        ),
      ],
    );
  }
}