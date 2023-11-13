import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/features/auth/auth.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/settings/settings.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

final List<RepositoryProvider> repositoryProviders = [
  RepositoryProvider<CharactersRepository>(
    create: (context) => CharactersRepositoryImpl(
      CharactersDatasourceImpl(),
    ),
  ),
  RepositoryProvider<EpisodesRepository>(
    create: (context) => EpisodesRepositoryImpl(
      EpisodeDatasourceImpl(),
    ),
  ),
  RepositoryProvider<LocalStorageRepository>(
    create: (context) => LocalStorageRepositoryImpl(
      LocalStorageDatasourceImpl(),
    ),
  ),
  RepositoryProvider<AuthRepository>(
    create: (context) => AuthRepositoryImpl(
      AuthDatasourceImpl(),
    ),
  ),
  RepositoryProvider<KeyValueStorageService>(
    create: (context) => KeyValueStorageServiceImpl(),
  ),
  RepositoryProvider<LocationsRepository>(
    create: (context) => LocationsRepositoryImpl(
      LocationsDatasourceImpl(),
    ),
  ),
];

final List<BlocProvider> blocProviders = [
  BlocProvider<CharactersBloc>(
    create: (context) => CharactersBloc(
      getCharactersByPage:
          context.read<CharactersRepository>().getCharactersByPage,
    ),
  ),
  BlocProvider<CharacterBloc>(
    create: (context) => CharacterBloc(
      getCharacterById: context.read<CharactersRepository>().getCharacterById,
    ),
  ),
  BlocProvider<SearchCharactersBloc>(
    create: (context) => SearchCharactersBloc(
      searchCharacters: context.read<CharactersRepository>().searchCharacters,
    ),
  ),
  BlocProvider<EpisodesBloc>(
    create: (context) => EpisodesBloc(
      getEpisodesByPage: context.read<EpisodesRepository>().getEpisodesByPage,
    ),
  ),
  BlocProvider<EpisodeBloc>(
    create: (context) => EpisodeBloc(
      getEpisodeById: context.read<EpisodesRepository>().getEpisodeById,
    ),
  ),
  BlocProvider<SearchEpisodesBloc>(
    create: (context) => SearchEpisodesBloc(
      searchEpisodes: context.read<EpisodesRepository>().searchEpisodes,
    ),
  ),
  BlocProvider<EpisodesByCharacterBloc>(
    create: (context) => EpisodesByCharacterBloc(
      getEpisodesByCharacter:
          context.read<EpisodesRepository>().getEpisodesByList,
    ),
  ),
  BlocProvider<CharactersByEpisodeBloc>(
    create: (context) => CharactersByEpisodeBloc(
      getCharactersByEpisode:
          context.read<CharactersRepository>().getCharactersByList,
    ),
  ),
  BlocProvider<FavoritesEpisodesBloc>(
    create: (context) => FavoritesEpisodesBloc(
      localStorageRepository: context.read<LocalStorageRepository>(),
    ),
  ),
  BlocProvider<CharactersSlideCubit>(
    create: (context) => CharactersSlideCubit(
      getCharactersByIds:
          context.read<CharactersRepository>().getCharactersByList,
    ),
  ),
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(
      authServices: context.read<AuthRepository>(),
    ),
  ),
  BlocProvider<SettingsCubit>(
    create: (context) => SettingsCubit(
      keyValueStorageService: context.read<KeyValueStorageService>(),
    ),
  ),
  BlocProvider<LocationsBloc>(
    create: (context) => LocationsBloc(
      getLocationsByPage:
          context.read<LocationsRepository>().getLocationsByPage,
    ),
  ),
  BlocProvider<SearchLocationsBloc>(
    create: (context) => SearchLocationsBloc(
      searchLocations: context.read<LocationsRepository>().searchLocations,
    ),
  ),
  BlocProvider<LocationCubit>(
    create: (context) => LocationCubit(
      getLocationById: context.read<LocationsRepository>().getLocationById,
    ),
  ),
  BlocProvider<ResidentsByLocationBloc>(
    create: (context) => ResidentsByLocationBloc(
      getResidentsByLocation:
          context.read<CharactersRepository>().getCharactersByList,
    ),
  ),
];
