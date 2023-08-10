import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/home/home.dart';

class SideMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: context.select(
          (NavDrawerCubit navDrawerCubit) => navDrawerCubit.state.currentIndex),
      onDestinationSelected: (value) {
        context.read<NavDrawerCubit>().setCurrentIndex(value);

        Future.delayed(const Duration(milliseconds: 200)).then((_) {
          final menuOption = menuOptions[value];

          context.go(menuOption.link);

          scaffoldKey.currentState?.closeDrawer();
        });
      },
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            "AppMaking.co",
            style: textThemes.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text(
            "sundar@appmaking.co",
            style: textThemes.titleSmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          currentAccountPicture: const CircleAvatar(
            // backgroundImage: NetworkImage(""),
            child: Icon(Icons.person),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.4,
              image: AssetImage(
                "assets/images/drawer_background.webp",
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: Text(
            "Opciones",
            style: textThemes.titleLarge,
          ),
        ),
        ...menuOptions.map(
          (option) => NavigationDrawerDestination(
            icon: CircleAvatar(
              backgroundImage: AssetImage(option.image),
            ),
            label: Text(
              option.title,
              style: textThemes.titleSmall?.copyWith(
                fontSize: 26.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
