import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/domain/usecases/get_character_by_id.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAppRepository mockAppRepository;
  late GetCharacterById usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = GetCharacterById(repository: mockAppRepository);
  });

  test('Should return character when call to remote data is successful',
      () async {
    //arrange
    when(mockAppRepository.getCharacterById(id: 2))
        .thenAnswer((_) async => Right(tCharacter));
    //act
    final result = await usecase.execute(id: 2);
    //assert
    expect(result, Right(tCharacter));
  });
}
