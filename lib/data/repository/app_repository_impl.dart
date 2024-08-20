import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/data/datasources/local_datasource/local_datasource.dart';
import 'package:rick_and_morty/data/datasources/remote_datasource/remote_datasource.dart';
import 'package:rick_and_morty/data/models/character_table.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/repository/app_repository.dart';
import 'package:rick_and_morty/utils/exception.dart';
import 'package:rick_and_morty/utils/failure.dart';

class AppRepositoryImpl implements AppRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AppRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<Either<Failure, List<Character>>> getAllCharacters(
      {int page = 1}) async {
    try {
      final result = await remoteDataSource.getAllCharacters(page: page);
      return Right(
          result.characterList.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacterById({required int id}) async {
    try {
      final result = await remoteDataSource.getCharacterById(id: id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> searchCharacter(
      {required String name}) async {
    try {
      final result = await remoteDataSource.searchCharacter(name: name);
      return Right(
          result.characterList.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on NotFoundException {
      return const Left(NotFoundFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> insertFavorite(Character character) async {
    try {
      final result = await localDataSource
          .insertFavorite(CharacterTable.fromEntity(character));
      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Terjadi Kesalahan!'));
    }
  }

  @override
  Future<Either<Failure, String>> removeFavorite(Character character) async {
    try {
      final result = await localDataSource
          .removeFavorite(CharacterTable.fromEntity(character));
      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Terjadi Kesalahan!'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getFavoriteCharacters() async {
    final result = await localDataSource.getFavoriteCharacters();
    return Right(result.map((table) => table.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToFavorite(int id) async {
    final result = await localDataSource.getCharacterById(id);
    return result != null;
  }
}
