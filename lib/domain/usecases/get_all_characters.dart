import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/repository/app_repository.dart';
import 'package:rick_and_morty/utils/failure.dart';

class GetAllCharacters {
  final AppRepository repository;

  GetAllCharacters({required this.repository});

  Future<Either<Failure, List<Character>>> execute({int page = 1}) =>
      repository.getAllCharacters(page: page);
}
