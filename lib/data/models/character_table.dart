import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/domain/entities/character.dart';

class CharacterTable extends Equatable {
  final int id;
  final String name;
  final String image;
  final String originName;

  const CharacterTable({
    required this.id,
    required this.name,
    required this.image,
    required this.originName,
  });

  factory CharacterTable.fromMap(Map<String, dynamic> map) => CharacterTable(
        id: map["id"],
        name: map["name"],
        image: map["image"],
        originName: map['originName'],
      );

  factory CharacterTable.fromEntity(Character entity) => CharacterTable(
        id: entity.id,
        name: entity.name,
        image: entity.image,
        originName: entity.origin.name,
      );

  factory CharacterTable.fromModel(CharacterModel model) => CharacterTable(
        id: model.id,
        name: model.name,
        image: model.image,
        originName: model.origin.name,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "originName": originName,
      };

  Character toEntity() => Character.favorite(
      id: id,
      name: name,
      image: image,
      origin: Location(name: originName, url: ''));

  @override
  List<Object?> get props => [id, name, image, originName];
}
