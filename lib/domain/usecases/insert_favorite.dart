import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/repository/app_repository.dart';
import 'package:rick_and_morty/utils/failure.dart';

class InsertFavorite {
  final AppRepository repository;

  InsertFavorite({required this.repository});

  Future<Either<Failure, String>> execute(Character character) =>
      repository.insertFavorite(character);
}
