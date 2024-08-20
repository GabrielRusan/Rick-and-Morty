import 'package:dio/dio.dart';
import 'package:rick_and_morty/constants/constants.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/models/character_response_model.dart';
import 'package:rick_and_morty/utils/exception.dart';

abstract class RemoteDataSource {
  Future<CharacterResponseModel> getAllCharacters({int page = 1});
  Future<CharacterModel> getCharacterById({required int id});
  Future<CharacterResponseModel> searchCharacter({required String name});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  const RemoteDataSourceImpl({required this.dio});

  @override
  Future<CharacterResponseModel> getAllCharacters({int page = 1}) async {
    try {
      final result = await dio.get('$baseUrl/character/?page=$page');
      return CharacterResponseModel.fromJson(result.data);
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<CharacterModel> getCharacterById({required int id}) async {
    try {
      final result = await dio.get('$baseUrl/character/$id');
      return CharacterModel.fromJson(result.data);
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<CharacterResponseModel> searchCharacter({required String name}) async {
    try {
      final result = await dio.get('$baseUrl/character/?name=$name');
      return CharacterResponseModel.fromJson(result.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw NotFoundException();
      } else {
        throw ServerException();
      }
    }
  }
}
