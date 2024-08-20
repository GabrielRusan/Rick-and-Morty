import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/utils/failure.dart';

abstract class AppRepository {
  Future<Either<Failure, List<Character>>> getAllCharacters({int page = 1});
  Future<Either<Failure, Character>> getCharacterById({required int id});
  Future<Either<Failure, List<Character>>> searchCharacter(
      {required String name});

  Future<Either<Failure, String>> insertFavorite(Character character);
  Future<Either<Failure, String>> removeFavorite(Character character);
  Future<Either<Failure, List<Character>>> getFavoriteCharacters();
  Future<bool> isAddedToFavorite(int id);
}
