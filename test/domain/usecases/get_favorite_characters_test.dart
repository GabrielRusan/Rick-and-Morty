import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/domain/usecases/get_favorite_characters.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAppRepository mockAppRepository;
  late GetFavoriteCharacters usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = GetFavoriteCharacters(repository: mockAppRepository);
  });

  test('Should return character list when call to remote data is successful',
      () async {
    //arrange
    when(mockAppRepository.getFavoriteCharacters())
        .thenAnswer((_) async => Right([tCharacter]));
    //act
    final result = await usecase.execute();
    //assert
    final resultList = result.getOrElse(() => []);
    expect(resultList, [tCharacter]);
  });
}
