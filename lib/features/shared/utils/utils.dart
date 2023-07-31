import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class Utils {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static String appBarTitle<T>(T element) {
    switch (element) {
      case Character:
        return "Personajes";
      case Episode:
        return "Episodios";
      default:
        return "";
    }
  }

  static String searchLabel<T>(T element) {
    switch (element) {
      case Character:
        return 'Buscar personaje';
      case Episode:
        return 'Buscar episodio';
      default:
        return 'Buscar';
    }
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

   static String loadingErrorMessage<T>(T element) {
    switch (element) {
      case Character:
        return "No existen personajes cargados";
      case Episode:
        return "No existen episodios cargados";
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
}
