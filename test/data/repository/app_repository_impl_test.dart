import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/data/repository/app_repository_impl.dart';
import 'package:rick_and_morty/utils/exception.dart';
import 'package:rick_and_morty/utils/failure.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late AppRepositoryImpl appRepositoryImpl;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    appRepositoryImpl = AppRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource);
  });

  group("from remote data source", () {
    group('get all characters', () {
      test(
          'Should return character list when call to remote data is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getAllCharacters(page: 2))
            .thenAnswer((_) async => tCharacterResponsModel);
        //act
        final result = await appRepositoryImpl.getAllCharacters(page: 2);
        //assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tCharacter]);
      });

      test(
          'should return server failure when call to remote source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAllCharacters())
            .thenThrow(ServerException());
        // act
        final result = await appRepositoryImpl.getAllCharacters();
        // assert
        expect(result, const Left(ServerFailure('')));
      });
    });

    group('get character by id', () {
      test('Should return character when call to remote data is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getCharacterById(id: 2))
            .thenAnswer((_) async => tCharacterModel);
        //act
        final result = await appRepositoryImpl.getCharacterById(id: 2);
        //assert
        expect(result, Right(tCharacter));
      });

      test(
          'should return server failure when call to remote source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getCharacterById(id: 2))
            .thenThrow(ServerException());
        // act
        final result = await appRepositoryImpl.getCharacterById(id: 2);
        // assert
        expect(result, const Left(ServerFailure('')));
      });
    });

    group('search characters', () {
      test(
          'Should return character list when call to remote data is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.searchCharacter(name: 'name'))
            .thenAnswer((_) async => tCharacterResponsModel);
        //act
        final result = await appRepositoryImpl.searchCharacter(name: 'name');
        //assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tCharacter]);
      });

      test(
          'should return not found failure when call to remote source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchCharacter(name: 'name'))
            .thenThrow(NotFoundException());
        // act
        final result = await appRepositoryImpl.searchCharacter(name: 'name');
        // assert
        expect(result, const Left(NotFoundFailure('')));
      });

      test(
          'should return server failure when call to remote source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchCharacter(name: 'name'))
            .thenThrow(ServerException());
        // act
        final result = await appRepositoryImpl.searchCharacter(name: 'name');
        // assert
        expect(result, const Left(ServerFailure('')));
      });
    });
  });

  group('from local data source', () {
    group('Insert favorite', () {
      test(
          'Should return valid message when call to local data source is successful',
          () async {
        //arrange
        when(mockLocalDataSource.insertFavorite(tCharacterTable))
            .thenAnswer((_) async => 'Added to Favorite');
        //act
        final result = await appRepositoryImpl.insertFavorite(tCharacter);
        //assert
        expect(result, const Right('Added to Favorite'));
      });

      test(
          'Should return database failure when call to local data source is failed',
          () async {
        //arrange
        when(mockLocalDataSource.insertFavorite(tCharacterTable))
            .thenThrow(DatabaseException(''));
        //act
        final result = await appRepositoryImpl.insertFavorite(tCharacter);
        //assert
        expect(result, const Left(DatabaseFailure('Terjadi Kesalahan!')));
      });
    });

    group('Remove favorite', () {
      test(
          'Should return valid message when call to local data source is successful',
          () async {
        //arrange
        when(mockLocalDataSource.removeFavorite(tCharacterTable))
            .thenAnswer((_) async => 'Removed from Favorite');
        //act
        final result = await appRepositoryImpl.removeFavorite(tCharacter);
        //assert
        expect(result, const Right('Removed from Favorite'));
      });

      test(
          'Should return database failure when call to local data source is failed',
          () async {
        //arrange
        when(mockLocalDataSource.removeFavorite(tCharacterTable))
            .thenThrow(DatabaseException(''));
        //act
        final result = await appRepositoryImpl.removeFavorite(tCharacter);
        //assert
        expect(result, const Left(DatabaseFailure('Terjadi Kesalahan!')));
      });
    });

    group('Remove favorite', () {
      test(
          'Should return valid message when call to local data source is successful',
          () async {
        //arrange
        when(mockLocalDataSource.removeFavorite(tCharacterTable))
            .thenAnswer((_) async => 'Removed from Favorite');
        //act
        final result = await appRepositoryImpl.removeFavorite(tCharacter);
        //assert
        expect(result, const Right('Removed from Favorite'));
      });

      test(
          'Should return database failure when call to local data source is failed',
          () async {
        //arrange
        when(mockLocalDataSource.removeFavorite(tCharacterTable))
            .thenThrow(DatabaseException(''));
        //act
        final result = await appRepositoryImpl.removeFavorite(tCharacter);
        //assert
        expect(result, const Left(DatabaseFailure('Terjadi Kesalahan!')));
      });
    });

    group('get favorite character', () {
      test(
          'Should return list character when call to local data source is successful',
          () async {
        //arrange
        when(mockLocalDataSource.getFavoriteCharacters())
            .thenAnswer((_) async => [tCharacterTable]);
        //act
        final result = await appRepositoryImpl.getFavoriteCharacters();
        //assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tCharacterFromDb]);
      });
    });

    group('get favorite status', () {
      test('Should return true when character is in favorite table', () async {
        //arrange
        when(mockLocalDataSource.getCharacterById(1))
            .thenAnswer((_) async => tCharacterTable);
        //act
        final result = await appRepositoryImpl.isAddedToFavorite(1);
        //assert
        expect(result, true);
      });

      test('Should return false when character is not found in favorite table',
          () async {
        //arrange
        when(mockLocalDataSource.getCharacterById(1))
            .thenAnswer((_) async => null);
        //act
        final result = await appRepositoryImpl.isAddedToFavorite(1);
        //assert
        expect(result, false);
      });
    });
  });
}
