import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/data/datasources/local_datasource/local_datasource.dart';
import 'package:rick_and_morty/utils/exception.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late LocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    localDataSourceImpl =
        LocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('insert favorite', () {
    test('should get valid message when call to database is successful',
        () async {
      //arrange
      when(mockDatabaseHelper.insertFavorite(tCharacterTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await localDataSourceImpl.insertFavorite(tCharacterTable);
      //assert
      expect(result, 'Added to Favorite');
    });

    test('should throw databaseexception when insert failed', () async {
      // arrange
      when(mockDatabaseHelper.insertFavorite(tCharacterTable))
          .thenThrow(Exception());
      // act
      final call = localDataSourceImpl.insertFavorite(tCharacterTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove favorite', () {
    test('should get valid message when call to database is successful',
        () async {
      //arrange
      when(mockDatabaseHelper.removeFavorite(tCharacterTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await localDataSourceImpl.removeFavorite(tCharacterTable);
      //assert
      expect(result, 'Removed from Favorite');
    });

    test('should throw databaseexception when insert failed', () async {
      // arrange
      when(mockDatabaseHelper.removeFavorite(tCharacterTable))
          .thenThrow(Exception());
      // act
      final call = localDataSourceImpl.removeFavorite(tCharacterTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get character by id', () {
    test('should get valid message when call to database is successful',
        () async {
      //arrange
      when(mockDatabaseHelper.getCharacterById(1))
          .thenAnswer((_) async => tCharacterTable.toMap());
      //act
      final result = await localDataSourceImpl.getCharacterById(1);
      //assert
      expect(result, tCharacterTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getCharacterById(1))
          .thenAnswer((_) async => null);
      // act
      final result = await localDataSourceImpl.getCharacterById(1);
      // assert
      expect(result, null);
    });
  });

  group('get favorite characters', () {
    test('should return list of CharacterTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getFavoriteCharacters())
          .thenAnswer((_) async => [tMapTable]);
      // act
      final result = await localDataSourceImpl.getFavoriteCharacters();
      // assert
      expect(result, [tCharacterTable]);
    });
  });
}
