import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (_) => NavDrawerCubit(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Image.asset(
            'assets/images/app_bar_background.png',
            height: kToolbarHeight - 4.0,
          ),
          centerTitle: true,
        ),
        body: const HomeView(),
        drawer: SideMenu(
          scaffoldKey: scaffoldKey,
        ),
      ),
    );
  }
}
