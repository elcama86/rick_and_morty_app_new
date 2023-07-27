import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

final charactersRepository =
    CharactersRepositoryImpl(CharactersDatasourceImpl());
final episodesRepository = EpisodeRepositoryImpl(EpisodeDatasourceImpl());

final List<BlocProvider> blocProviders = [
  BlocProvider<CharactersBloc>(
    create: (_) => CharactersBloc(
      getCharactersByPage: charactersRepository.getCharactersByPage,
    ),
  ),
  BlocProvider<CharacterBloc>(
    create: (_) => CharacterBloc(
      getCharacterById: charactersRepository.getCharacterById,
    ),
  ),
  BlocProvider<SearchCharactersBloc>(
    create: (_) => SearchCharactersBloc(
      searchCharacters: charactersRepository.searchCharacters,
    ),
  ),
  BlocProvider<EpisodesBloc>(
    create: (_) => EpisodesBloc(
      getEpisodesByPage: episodesRepository.getEpisodesByPage,
    ),
  ),
  BlocProvider<EpisodeBloc>(
    create: (_) => EpisodeBloc(
      getEpisodeById: episodesRepository.getEpisodeById,
    ),
  ),
  BlocProvider<SearchEpisodesBloc>(
    create: (_) => SearchEpisodesBloc(
      searchEpisodes: episodesRepository.searchEpisodes,
    ),
  ),
];
