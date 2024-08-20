import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/data/models/character_table.dart';

import '../../dummy_data/dummy_object.dart';

void main() {
  group('toMap test', () {
    test('should return valid map from model', () {
      final result = tCharacterTable.toMap();
      expect(result, tMapTable);
    });
  });

  group('fromMap test', () {
    test('should return valid model from map', () {
      final result = CharacterTable.fromMap(tMapTable);
      expect(result, tCharacterTable);
    });
  });
}
