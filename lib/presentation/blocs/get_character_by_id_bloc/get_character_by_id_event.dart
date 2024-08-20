part of 'get_character_by_id_bloc.dart';

sealed class GetCharacterByIdEvent extends Equatable {
  const GetCharacterByIdEvent();

  @override
  List<Object> get props => [];
}

final class FetchCharacterById extends GetCharacterByIdEvent {
  final int id;

  const FetchCharacterById({required this.id});
  @override
  List<Object> get props => [id];
}
