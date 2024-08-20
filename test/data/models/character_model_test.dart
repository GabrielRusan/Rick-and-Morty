import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  test('Should get valid model from json', () {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/character.json'));
    // act
    final result = CharacterModel.fromJson(jsonMap);
    // assert
    expect(result, tCharacterModel);
  });
}
