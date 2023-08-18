import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/auth/presentation/screens/screens.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/home/home.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorEpisodesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellEpisodes');

final appRouter = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
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
          routes: [
            GoRoute(
              path: 'character/:id',
              pageBuilder: (context, state) {
                final characterId = state.pathParameters['id'] ?? 'no-id';

                return transitionAnimationPage(
                  key: state.pageKey,
                  child: CharacterScreen(
                    characterId: characterId,
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellRoute(
          pageBuilder: (context, state, navigationShell) =>
              transitionAnimationPage(
            key: state.pageKey,
            child: navigationShell,
          ),
          navigatorContainerBuilder: (context, navigationShell, children) =>
              EpisodesScreen(
            navigationShell: navigationShell,
            children: children,
          ),
          branches: [
            StatefulShellBranch(
              navigatorKey: _shellNavigatorEpisodesKey,
              routes: [
                GoRoute(
                  path: 'episodes',
                  builder: (context, state) => const EpisodesView(),
                  routes: [
                    GoRoute(
                      path: 'episode/:id',
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (context, state) {
                        final episodeId = state.pathParameters['id'] ?? 'no-id';

                        return transitionAnimationPage(
                          key: state.pageKey,
                          child: EpisodeScreen(
                            episodeId: episodeId,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'favorites',
                  builder: (context, state) => const FavoritesEpisodesView(),
                ),
              ],
            ),
          ],
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
