import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/home/home.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'characters',
          pageBuilder: (context, state) => transitionAnimationPage(
            key: state.pageKey,
            child: const CharactersScreen(),
          ),
        ),
      ],
    ),
  ],
);

CustomTransitionPage<void> transitionAnimationPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      });
}
