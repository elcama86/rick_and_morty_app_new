import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class SideMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
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
        _UserAccountInfo(),
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: Text(
            AppLocalizations.of(context).translate('options'),
            style: textThemes.titleLarge,
          ),
        ),
        ...menuOptions.sublist(0, 3).map(
              (option) => NavigationDrawerDestination(
                icon: _IconOption(
                  option: option,
                ),
                label: Text(
                  AppLocalizations.of(context).translate(option.title),
                  style: textThemes.titleSmall?.copyWith(
                    fontSize: 26.0,
                  ),
                ),
              ),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text(
            AppLocalizations.of(context).translate('other_options'),
            style: textThemes.titleLarge,
          ),
        ),
        ...menuOptions.sublist(3).map(
              (option) => NavigationDrawerDestination(
                icon: _IconOption(
                  option: option,
                ),
                label: Text(
                  AppLocalizations.of(context).translate(option.title),
                  style: textThemes.titleSmall?.copyWith(
                    fontSize: 26.0,
                  ),
                ),
              ),
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            height: 50.0,
            width: double.infinity,
            child: CustomFilledButton(
              buttonColor: colors.outlineVariant,
              textColor: colors.onSurface,
              onPressed: () => context.read<AuthBloc>().add(LogoutRequest()),
              text: 'logout',
              setTextTheme: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _IconOption extends StatelessWidget {
  final MenuOption option;

  const _IconOption({
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    return option.image.isEmpty
        ? Icon(option.icon)
        : CircleAvatar(
            backgroundImage: AssetImage(option.image),
          );
  }
}

class _UserAccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: (context, state) => UserAccountsDrawerHeader(
        accountName: Text(
          state.user.name.isNotEmpty ? state.user.name : '',
          style: textThemes.titleMedium,
        ),
        accountEmail: Text(
          state.user.email.isNotEmpty ? state.user.email : '',
          style: textThemes.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundImage: state.user.imageUrl.isNotEmpty
              ? CachedNetworkImageProvider(state.user.imageUrl)
              : null,
          child:
              state.user.imageUrl.isNotEmpty ? null : const Icon(Icons.person),
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
    );
  }
}
