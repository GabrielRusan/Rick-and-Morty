import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

// ignore: must_be_immutable
class Character extends Equatable {
  int id;
  String name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Location origin;
  Location? location;
  String image;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  Character.favorite({
    required this.id,
    required this.name,
    required this.image,
    required this.origin,
  });

  @override
  List<Object?> get props =>
      [id, name, status, species, type, gender, origin, location, image];
}
