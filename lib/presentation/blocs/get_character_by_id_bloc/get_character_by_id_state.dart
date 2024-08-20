part of 'get_character_by_id_bloc.dart';

sealed class GetCharacterByIdState extends Equatable {
  const GetCharacterByIdState();

  @override
  List<Object> get props => [];
}

final class GetCharacterByIdLoading extends GetCharacterByIdState {}

final class GetCharacterByIdError extends GetCharacterByIdState {}

final class GetCharacterByIdLoaded extends GetCharacterByIdState {
  final Character character;

  const GetCharacterByIdLoaded({required this.character});

  @override
  List<Object> get props => [character];
}
