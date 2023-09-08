import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/config/router/app_router_notifier.dart';
import 'package:rick_and_morty_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:rick_and_morty_app/features/auth/presentation/screens/screens.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/home/home.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class AppRouter {
  late final GoRouterNotifier goRouterNotifier;

  AppRouter(this.goRouterNotifier);

  GoRouter get router => _goRouter;

  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _shellNavigatorEpisodesKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellEpisodes');

  late final GoRouter _goRouter = GoRouter(
    initialLocation: '/splash',
    navigatorKey: _rootNavigatorKey,
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          final authStatus = goRouterNotifier.authStatus;

          return CheckAuthStatusScreen(
            status: authStatus,
          );
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
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
                path: 'character',
                pageBuilder: (context, state) {
                  final characterId = state.queryParameters['id'] ?? 'no-id';
                  final characterName =
                      state.queryParameters['name'] ?? 'no-name';

                  return transitionAnimationPage(
                    key: state.pageKey,
                    child: CharacterScreen(
                      characterId: characterId,
                      characterName: characterName,
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
                          final episodeId =
                              state.pathParameters['id'] ?? 'no-id';

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
          GoRoute(
            path: 'settings',
            pageBuilder: (context, state) => transitionAnimationPage(
              key: state.pageKey,
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' &&
          (authStatus == AuthStatus.checking ||
              authStatus == AuthStatus.loading)) {
        return null;
      }

      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
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
}
