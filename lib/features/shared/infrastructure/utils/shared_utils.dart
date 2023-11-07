import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

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

  static String loadingElementsMessageError<T>(T entity) {
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
    List<String> keyArray = text.split(',');

    String translatedText = '';

    for (String key in keyArray) {
      String text = AppLocalizations.of(context).translate(key).isNotEmpty
          ? AppLocalizations.of(context).translate(key)
          : key;
      translatedText = '$translatedText $text';
    }

    return translatedText;
  }

  static Widget actionSearchWidget<T>(
      BuildContext context, Widget loadingSpinner, Widget closeSearch) {
    switch (T) {
      case Character:
        return BlocBuilder<SearchCharactersBloc, SearchCharactersState>(
          builder: (context, state) => actionSearchStateWidget(
              state.isLoading, loadingSpinner, closeSearch),
        );
      case Episode:
        return BlocBuilder<SearchEpisodesBloc, SearchEpisodesState>(
          builder: (context, state) => actionSearchStateWidget(
              state.isLoading, loadingSpinner, closeSearch),
        );
      case Location:
        return BlocBuilder<SearchLocationsBloc, SearchLocationsState>(
          builder: (context, state) => actionSearchStateWidget(
              state.isLoading, loadingSpinner, closeSearch),
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

  static void getElement<T>(BuildContext context, String id) {
    switch (T) {
      case Character:
        context.read<CharacterBloc>().getCharacter(id);
        break;
      case Episode:
        context.read<EpisodeBloc>().getEpisode(id);
        break;
      case Location:
        context.read<LocationCubit>().getLocation(id);
      default:
        throw UnimplementedError();
    }
  }

  static String loadingElementMessage<T>() {
    switch (T) {
      case Character:
        return 'loading_character';
      case Episode:
        return 'loading_episode';
      case Location:
        return 'loading_location';
      default:
        return '';
    }
  }

  static String errorLoadingElementMessage<T>() {
    switch (T) {
      case Character:
        return 'error_loading_character';
      case Episode:
        return 'error_loading_episode';
      case Location:
        return 'error_loading_location';
      default:
        return '';
    }
  }

  static Widget suggestionsAndResultsWidget<T>(
      BuildContext context, List<T> elements) {
    switch (T) {
      case Character:
        final listContain = ListView.builder(
          itemCount: elements.length,
          itemBuilder: (context, index) => CharacterSearchedItem(
            character: elements[index] as Character,
          ),
        );

        return BlocBuilder<SearchCharactersBloc, SearchCharactersState>(
          builder: (context, state) => suggestionsAndResultsContain(
              elements, state.errorMessage, listContain),
        );
      case Episode:
        final listContain = ListView.builder(
          itemCount: elements.length,
          itemBuilder: (context, index) => EpisodeSearchedItem(
            episode: elements[index] as Episode,
          ),
        );

        return BlocBuilder<SearchEpisodesBloc, SearchEpisodesState>(
          builder: (context, state) => suggestionsAndResultsContain(
              elements, state.errorMessage, listContain),
        );
      case Location:
        final listContain = ListView.builder(
          itemCount: elements.length,
          itemBuilder: (context, index) => LocationSearchedItem(
            location: elements[index] as Location,
          ),
        );

        return BlocBuilder<SearchLocationsBloc, SearchLocationsState>(
          builder: (context, state) => suggestionsAndResultsContain(
              elements, state.errorMessage, listContain),
        );
      default:
        return const SizedBox();
    }
  }

  static Widget suggestionsAndResultsContain<T>(
      List<T> elements, String errorMessage, Widget contain) {
    if (elements.isEmpty && errorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomMessage(
          message: errorMessage,
        ),
      );
    }

    return contain;
  }

  static Future<bool?> showAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    Color? iconColor,
    Color? cancelButtonColor,
    Color? acceptButtonColor,
  }) async {
    final textThemes = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return await showDialog<bool?>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Flash(
          duration: const Duration(milliseconds: 1500),
          infinite: true,
          child: const Icon(
            Icons.warning_amber,
            size: 36.0,
          ),
        ),
        iconColor: iconColor,
        titleTextStyle: textThemes.titleMedium,
        title: Text(
          AppLocalizations.of(context).translate(title),
        ),
        contentTextStyle: textThemes.titleSmall,
        content: Text(
          AppLocalizations.of(context).translate(message),
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              AppLocalizations.of(context).translate('cancel'),
              style: textThemes.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: cancelButtonColor ?? colors.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              AppLocalizations.of(context).translate('accept'),
              style: textThemes.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: acceptButtonColor ?? colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void checkDioException(DioException e, String entity) {
    if (e.response?.statusCode == 404) {
      switch (entity) {
        case 'character':
          throw CharacterNotFound();
        case 'episode':
          throw EpisodeNotFound();
        case 'location':
          throw LocationNotFound();
      }
    }
    if (e.type == DioExceptionType.connectionTimeout) {
      throw CustomError("check_connection");
    }
    if (e.type == DioExceptionType.connectionError &&
        e.error.runtimeType == SocketException) {
      throw CustomError("no_internet");
    }
  }
}
