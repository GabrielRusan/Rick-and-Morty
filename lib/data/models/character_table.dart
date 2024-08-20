import 'package:equatable/equatable.dart';

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

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "originName": originName,
      };

  @override
  List<Object?> get props => [id, name, image, originName];
}
