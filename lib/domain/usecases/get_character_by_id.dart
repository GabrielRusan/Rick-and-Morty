import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/repository/app_repository.dart';
import 'package:rick_and_morty/utils/failure.dart';

class GetCharacterById {
  final AppRepository repository;

  GetCharacterById({required this.repository});

  Future<Either<Failure, Character>> execute({required int id}) =>
      repository.getCharacterById(id: id);
}
