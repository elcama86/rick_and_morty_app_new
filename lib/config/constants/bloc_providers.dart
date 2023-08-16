import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/features/auth/auth.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

final charactersRepository =
    CharactersRepositoryImpl(CharactersDatasourceImpl());
final episodesRepository = EpisodeRepositoryImpl(EpisodeDatasourceImpl());
final localStorageRepository =
    LocalStorageRepositoryImpl(LocalStorageDatasourceImpl());
final authRepository = AuthRepositoryImpl(AuthDatasourceImpl());

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
  BlocProvider<EpisodesByCharacterBloc>(
    create: (_) => EpisodesByCharacterBloc(
      getEpisodesByCharacter: episodesRepository.getEpisodesByList,
    ),
  ),
  BlocProvider<CharactersByEpisodeBloc>(
    create: (_) => CharactersByEpisodeBloc(
      getCharactersByEpisode: charactersRepository.getCharactersByList,
    ),
  ),
  BlocProvider<FavoritesEpisodesBloc>(
    create: (_) => FavoritesEpisodesBloc(
      localStorageRepository: localStorageRepository,
    ),
  ),
  BlocProvider<CharactersSlideCubit>(
    create: (_) => CharactersSlideCubit(
      getCharactersByIds: charactersRepository.getCharactersByList,
    ),
  ),
  BlocProvider<AuthBloc>(
    create: (_) => AuthBloc(
      authServices: authRepository,
    ),
  )
];
