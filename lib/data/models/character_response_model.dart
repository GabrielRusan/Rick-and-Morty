import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class CharacterResponseModel extends Equatable {
  final List<CharacterModel> characterList;

  const CharacterResponseModel({
    required this.characterList,
  });

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) =>
      CharacterResponseModel(
        characterList: List<CharacterModel>.from(
            json["results"].map((x) => CharacterModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [characterList];
}
