import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/models/character_response_model.dart';
import 'package:rick_and_morty/data/models/character_table.dart';
import 'package:rick_and_morty/domain/entities/character.dart';

CharacterModel tCharacterModel = const CharacterModel(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    origin: Location(
        name: 'Earth (C-137)',
        url: 'https://rickandmortyapi.com/api/location/1'),
    location: Location(
        name: 'Citadel of Ricks',
        url: 'https://rickandmortyapi.com/api/location/3'),
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg');

CharacterResponseModel tCharacterResponsModel =
    CharacterResponseModel(characterList: [tCharacterModel]);

CharacterTable tCharacterTable = const CharacterTable(
    id: 1,
    name: 'Rick Sanchez',
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    originName: 'Earth (C-137)');

Map<String, dynamic> tMapTable = {
  "id": 1,
  "name": 'Rick Sanchez',
  "image": 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
  "originName": 'Earth (C-137)'
};

Character tCharacter = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    origin: const Location(
        name: 'Earth (C-137)',
        url: 'https://rickandmortyapi.com/api/location/1'),
    location: const Location(
        name: 'Citadel of Ricks',
        url: 'https://rickandmortyapi.com/api/location/3'),
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg');

Character tCharacterFromDb = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: null,
    species: null,
    type: null,
    gender: null,
    origin: const Location(name: 'Earth (C-137)', url: ''),
    location: null,
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg');

List<Character> tCharacterList = [tCharacter];
List<Character> tCharacterList20 = [
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
  tCharacter,
];
