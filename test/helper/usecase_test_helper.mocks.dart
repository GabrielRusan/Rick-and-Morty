// Mocks generated by Mockito 5.4.4 from annotations
// in rick_and_morty/test/helper/usecase_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rick_and_morty/domain/entities/character.dart' as _i7;
import 'package:rick_and_morty/domain/repository/app_repository.dart' as _i2;
import 'package:rick_and_morty/domain/usecases/get_all_characters.dart' as _i4;
import 'package:rick_and_morty/domain/usecases/get_character_by_id.dart' as _i8;
import 'package:rick_and_morty/domain/usecases/get_favorite_characters.dart'
    as _i9;
import 'package:rick_and_morty/domain/usecases/get_favorite_status.dart'
    as _i10;
import 'package:rick_and_morty/domain/usecases/insert_favorite.dart' as _i11;
import 'package:rick_and_morty/domain/usecases/remove_favorite.dart' as _i12;
import 'package:rick_and_morty/domain/usecases/search_character.dart' as _i13;
import 'package:rick_and_morty/utils/failure.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAppRepository_0 extends _i1.SmartFake implements _i2.AppRepository {
  _FakeAppRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetAllCharacters].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllCharacters extends _i1.Mock implements _i4.GetAllCharacters {
  MockGetAllCharacters() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeAppRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.AppRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>> execute(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#page: page},
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.Character>>(
          this,
          Invocation.method(
            #execute,
            [],
            {#page: page},
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>>);
}

/// A class which mocks [GetCharacterById].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCharacterById extends _i1.Mock implements _i8.GetCharacterById {
  MockGetCharacterById() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeAppRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.AppRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Character>> execute(
          {required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#id: id},
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Character>>.value(
            _FakeEither_1<_i6.Failure, _i7.Character>(
          this,
          Invocation.method(
            #execute,
            [],
            {#id: id},
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Character>>);
}

/// A class which mocks [GetFavoriteCharacters].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetFavoriteCharacters extends _i1.Mock
    implements _i9.GetFavoriteCharacters {
  MockGetFavoriteCharacters() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeAppRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.AppRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.Character>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>>);
}

/// A class which mocks [GetFavoriteStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetFavoriteStatus extends _i1.Mock implements _i10.GetFavoriteStatus {
  MockGetFavoriteStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeAppRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.AppRepository);

  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [InsertFavorite].
///
/// See the documentation for Mockito's code generation for more information.
class MockInsertFavorite extends _i1.Mock implements _i11.InsertFavorite {
  MockInsertFavorite() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeAppRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.AppRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.Character? character) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [character],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [character],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveFavorite].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveFavorite extends _i1.Mock implements _i12.RemoveFavorite {
  MockRemoveFavorite() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeAppRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.AppRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.Character? character) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [character],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [character],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [SearchCharacter].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchCharacter extends _i1.Mock implements _i13.SearchCharacter {
  MockSearchCharacter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeAppRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.AppRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>> execute(
          {required String? name}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#name: name},
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.Character>>(
          this,
          Invocation.method(
            #execute,
            [],
            {#name: name},
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Character>>>);
}
