import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/domain/usecases/get_favorite_status.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockAppRepository mockAppRepository;
  late GetFavoriteStatus usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = GetFavoriteStatus(repository: mockAppRepository);
  });

  test('Should return true when call data is in db', () async {
    //arrange
    when(mockAppRepository.isAddedToFavorite(1)).thenAnswer((_) async => true);
    //act
    final result = await usecase.execute(1);
    //assert
    expect(result, true);
  });
}
