import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/repository/app_repository.dart';
import 'package:rick_and_morty/utils/failure.dart';

class RemoveFavorite {
  final AppRepository repository;

  RemoveFavorite({required this.repository});

  Future<Either<Failure, String>> execute(Character character) =>
      repository.removeFavorite(character);
}
