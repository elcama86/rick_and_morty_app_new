import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/home/home.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersSlideCubit>().getCharactersSlide();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<CharactersSlideCubit, CharactersSlideState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: LoadingSpinner(),
          );
        }

        return BlocProvider(
          create: (_) => NavDrawerCubit(),
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) => Image.asset(
                  'assets/images/app_bar_background_${state.language}.png',
                  height: kToolbarHeight - 4.0,
                ),
              ),
              centerTitle: true,
            ),
            body: const HomeView(),
            drawer: SideMenu(
              scaffoldKey: scaffoldKey,
            ),
          ),
        );
      },
    );
  }
}
