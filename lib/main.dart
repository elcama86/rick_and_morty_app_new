import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/config/router/app_router_notifier.dart';
import 'package:rick_and_morty_app/features/auth/presentation/presentation.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

Future<void> main() async {
  await AppInitialization.initialize();

  runApp(
    MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(
        providers: blocProviders,
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthBloc>().state.status;
    final appRouter = AppRouter(GoRouterNotifier(authStatus)).router;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: appRouter,
          theme: AppTheme().light(),
          darkTheme: AppTheme().dark(),
          themeMode: state.themeMode,
          debugShowCheckedModeBanner: false,
          locale: !state.isSystemLanguage ? Locale(state.language) : null,
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: AppLocalizations.localeResolutionCallback,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        );
      },
    );
  }
}
