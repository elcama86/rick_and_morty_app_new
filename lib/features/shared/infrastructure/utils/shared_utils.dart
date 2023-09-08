import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class SharedUtils {
  static void showSnackbar(BuildContext context, String message,
      [Color? color, Color? textColor]) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.contains(',')
              ? specialTranslate(message, context)
              : AppLocalizations.of(context).translate(message),
          style: TextStyle(
            color: textColor,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  static String watchError<T>(T element, BuildContext context) {
    switch (element) {
      case Character:
        return context.watch<SearchCharactersBloc>().state.errorMessage;
      case Episode:
        return context.watch<SearchEpisodesBloc>().state.errorMessage;
      default:
        return '';
    }
  }

  static List<String> getIdsFromUrl(List<String> urls) {
    List<String> ids = urls
        .map((url) => url.split('/'))
        .toList()
        .map((e) => e[e.length - 1])
        .toList();

    return ids;
  }

  static int getEndIndex(int count, int length) {
    if (count + 10 > length) {
      return length;
    } else {
      return count + 10;
    }
  }

  static getElements<T>(T entity, BuildContext context) {
    switch (entity.runtimeType) {
      case Character:
        final Character character = entity as Character;
        return context
            .read<EpisodesByCharacterBloc>()
            .state
            .episodesByCharacter[character.id.toString()]?['episodes'];
      case Episode:
        final Episode episode = entity as Episode;
        return context
            .read<CharactersByEpisodeBloc>()
            .state
            .charactersByEpisode[episode.id.toString()]?['characters'];
      default:
        return [];
    }
  }

  static void loadElements<T>(T entity, BuildContext context) {
    switch (entity.runtimeType) {
      case Character:
        final Character character = entity as Character;
        final ids = getIdsFromUrl(character.episodes);
        context
            .read<EpisodesByCharacterBloc>()
            .loadEpisodes(character.id.toString(), ids);
        break;
      case Episode:
        final Episode episode = entity as Episode;
        final ids = getIdsFromUrl(episode.characters);
        context
            .read<CharactersByEpisodeBloc>()
            .loadCharacters(episode.id.toString(), ids);
        break;
      default:
        throw UnimplementedError();
    }
  }

  static watchElements<T>(T entity, BuildContext context) {
    switch (entity.runtimeType) {
      case Character:
        final Character character = entity as Character;
        return context
            .watch<EpisodesByCharacterBloc>()
            .state
            .episodesByCharacter[character.id.toString()]?['episodes'];

      case Episode:
        final Episode episode = entity as Episode;
        return context
            .watch<CharactersByEpisodeBloc>()
            .state
            .charactersByEpisode[episode.id.toString()]?['characters'];
      default:
        return [];
    }
  }

  static bool watchElementHasError<T>(T entity, BuildContext context) {
    switch (entity.runtimeType) {
      case Character:
        return context.watch<EpisodesByCharacterBloc>().state.hasError;
      case Episode:
        return context.watch<CharactersByEpisodeBloc>().state.hasError;
      default:
        return false;
    }
  }

  static String getLoadingElementMessageError<T>(T entity) {
    switch (entity.runtimeType) {
      case Character:
        return 'error_loading_episodes';
      case Episode:
        return 'error_loading_characters';
      default:
        return '';
    }
  }

  static String getElementRoute<T>(T element) {
    switch (element.runtimeType) {
      case Character:
        final Character character = element as Character;
        
        return Uri(
          path: '/characters/character',
          queryParameters: {
            'id': '${character.id}',
            'name': character.name,
          },
        ).toString();
      case Episode:
        final Episode episode = element as Episode;
        
        return '/episodes/episode/${episode.id}';
      default:
        return '';
    }
  }

  static String getElementName<T>(T element) {
    switch (element.runtimeType) {
      case Character:
        final Character character = element as Character;
        return character.name;
      case Episode:
        final Episode episode = element as Episode;
        return episode.name;
      default:
        return '';
    }
  }

  static Widget getChildWidget<T>(T element) {
    switch (element.runtimeType) {
      case Character:
        return CharacterCard(
          character: element as Character,
        );
      case Episode:
        return EpisodeCard(
          episode: element as Episode,
        );
      default:
        return const SizedBox();
    }
  }

  static PreferredSizeWidget? appBarContain<T>(
      List<T> elements, String title, BuildContext context) {
    if (elements.isEmpty) {
      return AppBar(
        title: Text(
          AppLocalizations.of(context).translate(title),
        ),
      );
    }

    return null;
  }

  static String specialTranslate(String text, BuildContext context) {
    List<String> textArray = text.split(',');

    String translateText = AppLocalizations.of(context).translate(textArray[0]);
    String otherText = textArray[1];

    return '$translateText $otherText';
  }

  static Widget actionSearchWidget<T>(
      BuildContext context, Widget loadingSpinner, Widget closeSearch) {
    switch (T) {
      case Character:
        return BlocBuilder<SearchCharactersBloc, SearchCharactersState>(
          builder: (context, state) {
            return actionSearchStateWidget(
                state.isLoading, loadingSpinner, closeSearch);
          },
        );
      case Episode:
        return BlocBuilder<SearchEpisodesBloc, SearchEpisodesState>(
          builder: (context, state) {
            return actionSearchStateWidget(
                state.isLoading, loadingSpinner, closeSearch);
          },
        );
      default:
        return const SizedBox();
    }
  }

  static Widget actionSearchStateWidget(
      bool isLoading, Widget loading, Widget close) {
    if (isLoading) {
      return loading;
    }
    return close;
  }
}
