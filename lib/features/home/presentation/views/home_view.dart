import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

import '../widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      child: BlocBuilder<CharactersSlideCubit, CharactersSlideState>(
        builder: (context, state) {
          if (state.hasError) {
            return _ErrorMessageRetry(
              isRetrying: state.isRetrying,
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              CharactersSlideShow(
                characters: state.characters,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const TrailerVideo(),
              const SizedBox(
                height: 20.0,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ErrorMessageRetry extends StatelessWidget {
  final bool isRetrying;

  const _ErrorMessageRetry({
    required this.isRetrying,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: isRetrying
                  ? const LoadingSpinner()
                  : Text(
                      "Ocurrió un error cargando la información",
                      textAlign: TextAlign.center,
                      style: textStyles.titleLarge,
                    ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton.icon(
            icon: isRetrying
                ? SpinPerfect(
                    duration: const Duration(seconds: 20),
                    spins: 10,
                    infinite: true,
                    child: const Icon(Icons.refresh_rounded),
                  )
                : const Icon(Icons.refresh_rounded),
            label: Text(
              'Reintentar',
              style: textStyles.titleSmall,
            ),
            onPressed: isRetrying
                ? null
                : context.read<CharactersSlideCubit>().getCharactersSlide,
          ),
        ],
      ),
    );
  }
}
