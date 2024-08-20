import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/models/character_response_model.dart';

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
