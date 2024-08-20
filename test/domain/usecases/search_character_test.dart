import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/domain/usecases/search_character.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAppRepository mockAppRepository;
  late SearchCharacter usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = SearchCharacter(repository: mockAppRepository);
  });

  test('Should return character list when call to remote data is successful',
      () async {
    //arrange
    when(mockAppRepository.searchCharacter(name: ''))
        .thenAnswer((_) async => Right([tCharacter]));
    //act
    final result = await usecase.execute(name: '');
    //assert
    final resultList = result.getOrElse(() => []);
    expect(resultList, [tCharacter]);
  });
}
