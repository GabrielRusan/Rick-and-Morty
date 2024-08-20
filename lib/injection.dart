import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/data/datasources/local_datasource/db/database_helper.dart';
import 'package:rick_and_morty/data/datasources/local_datasource/local_datasource.dart';
import 'package:rick_and_morty/data/datasources/remote_datasource/remote_datasource.dart';
import 'package:rick_and_morty/data/repository/app_repository_impl.dart';
import 'package:rick_and_morty/domain/repository/app_repository.dart';
import 'package:rick_and_morty/domain/usecases/get_all_characters.dart';
import 'package:rick_and_morty/domain/usecases/get_character_by_id.dart';
import 'package:rick_and_morty/domain/usecases/get_favorite_characters.dart';
import 'package:rick_and_morty/domain/usecases/get_favorite_status.dart';
import 'package:rick_and_morty/domain/usecases/insert_favorite.dart';
import 'package:rick_and_morty/domain/usecases/remove_favorite.dart';
import 'package:rick_and_morty/domain/usecases/search_character.dart';
import 'package:rick_and_morty/presentation/blocs/all_characters_bloc/all_characters_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/favorite_character_status_bloc/favorite_character_status_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/favorite_characters_bloc/favorite_characters_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/get_character_by_id_bloc/get_character_by_id_bloc.dart';

final locator = GetIt.instance;

void init() {
  //external
  locator.registerLazySingleton<Dio>(() => Dio());

  //helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  //datasources
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(databaseHelper: locator()));

  //repository
  locator.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));

  //usecases
  locator.registerLazySingleton(() => GetAllCharacters(repository: locator()));
  locator.registerLazySingleton(() => GetCharacterById(repository: locator()));
  locator.registerLazySingleton(
      () => GetFavoriteCharacters(repository: locator()));
  locator.registerLazySingleton(() => GetFavoriteStatus(repository: locator()));
  locator.registerLazySingleton(() => InsertFavorite(repository: locator()));
  locator.registerLazySingleton(() => RemoveFavorite(repository: locator()));
  locator.registerLazySingleton(() => SearchCharacter(repository: locator()));

  //blocs
  locator.registerFactory(() => AllCharactersBloc(locator()));
  locator.registerFactory(() => GetCharacterByIdBloc(locator()));
  locator.registerFactory(() => FavoriteCharacterBloc(locator()));
  locator.registerFactory(
      () => FavoriteCharacterStatusBloc(locator(), locator(), locator()));
}
