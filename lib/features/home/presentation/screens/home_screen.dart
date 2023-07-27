import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/shared/presentation/widgets/scaffold_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                ...menuOptions.map(
                  (option) => _MenuOption(
                    option: option,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final MenuOption option;

  const _MenuOption({
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push(option.link),
      child: Card(
        elevation: 50.0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        shadowColor: colors.primary,
        margin: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 30.0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              option.image,
              height: 180.0,
              width: 180.0,
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  stops: [0.5, 1.0],
                  colors: [
                    Colors.black54,
                    Colors.black45,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  option.title,
                  style: textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
