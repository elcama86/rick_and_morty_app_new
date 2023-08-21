import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/config/router/app_router_notifier.dart';
import 'package:rick_and_morty_app/features/auth/presentation/presentation.dart';

Future<void> main() async {
  await Certificate.register();
  await Environment.initEnvironment();
  await AuthBloc.initializeServices();
  HumanFormats.initializeDates();

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

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
