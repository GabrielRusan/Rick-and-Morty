import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/repository/app_repository.dart';
import 'package:rick_and_morty/utils/failure.dart';

class GetFavoriteCharacters {
  final AppRepository repository;

  GetFavoriteCharacters({required this.repository});

  Future<Either<Failure, List<Character>>> execute() =>
      repository.getFavoriteCharacters();
}
