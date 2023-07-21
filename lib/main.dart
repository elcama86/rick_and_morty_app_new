import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/characters/infrastructure/infrastructure.dart';

import 'features/characters/presentation/blocs/blocs.dart';

Future<void> main() async {
  await Certificate.register();
  await Environment.initEnvironment();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) {
          final charactersRepository =
              CharactersRepositoryImpl(CharactersDatasourceImpl());
          return CharactersBloc(
            charactersRepository: charactersRepository,
          );
        }),
      ],
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
