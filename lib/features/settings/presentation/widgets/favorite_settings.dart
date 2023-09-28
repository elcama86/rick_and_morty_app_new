import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class FavoritesSettings extends StatelessWidget {
  const FavoritesSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<FavoritesEpisodesBloc, FavoritesEpisodesState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(
                AppLocalizations.of(context).translate('favorites'),
                style: textThemes.titleMedium,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 40.0),
              title: Text(
                AppLocalizations.of(context).translate('selected_favorites'),
                style: textThemes.titleSmall,
              ),
              trailing: Text(
                '${state.totalFavorites}',
                style: textThemes.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: colors.error,
                textStyle: textThemes.titleSmall,
              ),
              onPressed: state.totalFavorites > 0
                  ? () => SharedUtils.showAlertDialog(
                        context: context,
                        title: 'attention',
                        message: 'confirm_delete_favorites_message',
                        acceptAction: context
                            .read<FavoritesEpisodesBloc>()
                            .clearEpisodesDb,
                        iconColor: colors.error,
                        acceptButtonColor: colors.error,
                      )
                  : null,
              icon: const Icon(Icons.delete_forever),
              label: Text(
                AppLocalizations.of(context).translate('delete_favorites'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        );
      },
    );
  }
}
