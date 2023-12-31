import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int index;
  final void Function(int, BuildContext) onItemTapped;

  const CustomBottomNavigation({
    super.key,
    required this.index,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        final position = state.currentPosition;
        final appBarHeight = state.appBarHeight;

        if (state.finalPosition == 0.0) {
          context.read<BottomNavBarCubit>().showAfterRemoveFavorite();
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: state.isVisible ? kBottomNavigationBarHeight : 0.0,
          child: Wrap(
            children: [
              BottomNavigationBar(
                elevation: 16.0,
                currentIndex: index,
                onTap: (value) => onItemTapped(value, context),
                selectedItemColor: colors.primary,
                showUnselectedLabels: true,
                unselectedItemColor: colors.secondary,
                backgroundColor: position > appBarHeight
                    ? colors.onInverseSurface
                    : scaffoldBackgroundColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      index == 0 ? Icons.home : Icons.home_outlined,
                    ),
                    label: AppLocalizations.of(context).translate('home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      index == 1 ? Icons.favorite : Icons.favorite_outline,
                    ),
                    label: AppLocalizations.of(context).translate('favorites'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
