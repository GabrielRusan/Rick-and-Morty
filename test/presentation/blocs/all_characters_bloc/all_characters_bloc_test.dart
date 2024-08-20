import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/presentation/blocs/all_characters_bloc/all_characters_bloc.dart';
import 'package:rick_and_morty/utils/failure.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helper/usecase_test_helper.mocks.dart';

void main() {
  late MockGetAllCharacters mockGetAllCharacters;
  late AllCharactersBloc allCharactersBloc;

  setUp(() {
    mockGetAllCharacters = MockGetAllCharacters();
    allCharactersBloc = AllCharactersBloc(mockGetAllCharacters);
  });

  test('Initial state should AllCharactersState', () {
    expect(allCharactersBloc.state, const AllCharactersState());
    expect(allCharactersBloc.state.status, AllCharactersStatus.initial);
  });

  group('Fetch AllCharacters Test', () {
    blocTest<AllCharactersBloc, AllCharactersState>(
      'emits nothing when characters has reached maximum amount',
      build: () {
        return allCharactersBloc;
      },
      seed: () => const AllCharactersState(hasReachedMax: true),
      act: (bloc) => bloc.add(FetchAllCharacters()),
      expect: () => [],
    );

    blocTest<AllCharactersBloc, AllCharactersState>(
      'drop new events when processing current event',
      build: () {
        when(mockGetAllCharacters.execute())
            .thenAnswer((_) async => Right(tCharacterList));
        return allCharactersBloc;
      },
      act: (bloc) => bloc
        ..add(FetchAllCharacters())
        ..add(FetchAllCharacters()),
      expect: () => [
        AllCharactersState(
          status: AllCharactersStatus.success,
          characters: tCharacterList,
          hasReachedMax: false,
        )
      ],
    );

    blocTest<AllCharactersBloc, AllCharactersState>(
      'throttle events',
      build: () {
        when(mockGetAllCharacters.execute())
            .thenAnswer((_) async => Right([tCharacter]));
        return allCharactersBloc;
      },
      act: (bloc) async {
        bloc.add(FetchAllCharacters());
        await Future<void>.delayed(Duration.zero);
        bloc.add(FetchAllCharacters());
      },
      expect: () => [
        AllCharactersState(
          status: AllCharactersStatus.success,
          characters: [tCharacter],
          hasReachedMax: false,
        )
      ],
    );

    group('when status is initial', () {
      blocTest<AllCharactersBloc, AllCharactersState>(
        'emits status failure when failed fetch data characters',
        build: () {
          when(mockGetAllCharacters.execute())
              .thenAnswer((_) async => const Left(ServerFailure('')));
          return allCharactersBloc;
        },
        act: (bloc) => bloc.add(FetchAllCharacters()),
        expect: () => [
          const AllCharactersState(
            status: AllCharactersStatus.failure,
          )
        ],
      );
      blocTest<AllCharactersBloc, AllCharactersState>(
        'emits successful status when usecase fetches initial characters',
        build: () {
          when(mockGetAllCharacters.execute())
              .thenAnswer((_) async => Right([tCharacter]));
          return allCharactersBloc;
        },
        act: (bloc) => bloc.add(FetchAllCharacters()),
        expect: () => [
          AllCharactersState(
            status: AllCharactersStatus.success,
            characters: [tCharacter],
          )
        ],
      );
    });

    group('when status is not initial', () {
      blocTest<AllCharactersBloc, AllCharactersState>(
        'emits status failure when failed fetch data characters',
        build: () {
          when(mockGetAllCharacters.execute())
              .thenAnswer((_) async => const Left(ServerFailure('')));
          return allCharactersBloc;
        },
        seed: () => const AllCharactersState(
            status: AllCharactersStatus.success, hasReachedMax: false),
        act: (bloc) => bloc.add(FetchAllCharacters()),
        expect: () => [
          const AllCharactersState(
            status: AllCharactersStatus.failure,
          )
        ],
      );

      blocTest<AllCharactersBloc, AllCharactersState>(
        'emits hasReachedMax true when data fetched are empty',
        build: () {
          when(mockGetAllCharacters.execute())
              .thenAnswer((_) async => const Right([]));
          return allCharactersBloc;
        },
        seed: () =>
            const AllCharactersState(status: AllCharactersStatus.failure),
        act: (bloc) => bloc.add(FetchAllCharacters()),
        expect: () => [
          const AllCharactersState(
            status: AllCharactersStatus.success,
            hasReachedMax: true,
          )
        ],
      );

      blocTest<AllCharactersBloc, AllCharactersState>(
        'emits hasReachedMax false when data fetched length are multiple of 20',
        build: () {
          when(mockGetAllCharacters.execute(page: 2))
              .thenAnswer((_) async => Right(tCharacterList20));
          return allCharactersBloc;
        },
        seed: () => AllCharactersState(
            status: AllCharactersStatus.success, characters: tCharacterList20),
        act: (bloc) => bloc.add(FetchAllCharacters()),
        expect: () => [
          AllCharactersState(
              status: AllCharactersStatus.success,
              hasReachedMax: false,
              characters: List.of(tCharacterList20)..addAll(tCharacterList20))
        ],
      );
    });
  });
}
