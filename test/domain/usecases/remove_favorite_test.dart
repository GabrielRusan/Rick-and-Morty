import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/domain/usecases/remove_favorite.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAppRepository mockAppRepository;
  late RemoveFavorite usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = RemoveFavorite(repository: mockAppRepository);
  });

  test('Should return character when call to remote data is successful',
      () async {
    //arrange
    when(mockAppRepository.removeFavorite(tCharacter))
        .thenAnswer((_) async => const Right(''));
    //act
    final result = await usecase.execute(tCharacter);
    //assert
    expect(result, const Right(''));
  });
}
