import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int index;
  final ValueChanged<int>? onItemTapped;

  const CustomBottomNavigation({
    super.key,
    required this.index,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bottomNavBarState = context.watch<BottomNavBarCubit>().state;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: bottomNavBarState.isVisible ? kBottomNavigationBarHeight : 0.0,
      child: Wrap(
        children: [
          BottomNavigationBar(
            elevation: 16.0,
            currentIndex: index,
            onTap: onItemTapped,
            selectedItemColor: colors.primary,
            type: BottomNavigationBarType.shifting,
            showUnselectedLabels: true,
            unselectedItemColor: colors.secondary,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.video_label_outlined),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: 'Favoritos',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
