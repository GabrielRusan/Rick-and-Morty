import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/data/datasources/remote_datasource/remote_datasource.dart';
import 'package:rick_and_morty/utils/exception.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helper/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  late MockDio mockDio;
  late RemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    remoteDataSourceImpl = RemoteDataSourceImpl(dio: mockDio);
  });

  group('GetAllCharacters test', () {
    test('Should get valid model when call to API is successful', () async {
      //arrange
      when(mockDio.get(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(readJson('dummy_data/character_response.json'))));
      //act
      final result = await remoteDataSourceImpl.getAllCharacters();
      //assert
      expect(result, tCharacterResponsModel);
    });

    test('Should throw ServerException when call to API is not successful',
        () async {
      //arrange
      when(mockDio.get(any))
          .thenThrow(DioException(requestOptions: RequestOptions()));
      //act
      final call = remoteDataSourceImpl.getAllCharacters();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('GetCharacterById test', () {
    test('Should get valid model when call to API is successful', () async {
      //arrange
      when(mockDio.get(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(readJson('dummy_data/character.json'))));
      //act
      final result = await remoteDataSourceImpl.getCharacterById(id: 1);
      //assert
      expect(result, tCharacterModel);
    });

    test('Should throw ServerException when call to API is not successful',
        () async {
      //arrange
      when(mockDio.get(any))
          .thenThrow(DioException(requestOptions: RequestOptions()));
      //act
      final call = remoteDataSourceImpl.getCharacterById(id: 1);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('SearchCharacter test', () {
    test('Should get valid model when call to API is successful', () async {
      //arrange
      when(mockDio.get(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(readJson('dummy_data/character_response.json'))));
      //act
      final result = await remoteDataSourceImpl.searchCharacter(name: 'Rick');
      //assert
      expect(result, tCharacterResponsModel);
    });

    test('Should throw NotFoundException when dio throw badResponse', () async {
      //arrange
      when(mockDio.get(any)).thenThrow(DioException.badResponse(
          statusCode: 404,
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions())));
      //act
      final call = remoteDataSourceImpl.searchCharacter(name: 'Rick');
      //assert
      expect(() => call, throwsA(isA<NotFoundException>()));
    });

    test('Should throw ServerException when call to API is not successful',
        () async {
      //arrange
      when(mockDio.get(any))
          .thenThrow(DioException(requestOptions: RequestOptions()));
      //act
      final call = remoteDataSourceImpl.searchCharacter(name: 'Rick');
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
