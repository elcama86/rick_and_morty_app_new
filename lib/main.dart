import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/config/config.dart';

Future<void> main() async {
  await Certificate.register();
  await Environment.initEnvironment();
  HumanFormats.initializeDates();

  runApp(
    MultiBlocProvider(
      providers: blocProviders,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
