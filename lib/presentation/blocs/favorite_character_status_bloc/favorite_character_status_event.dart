part of 'favorite_character_status_bloc.dart';

sealed class FavoriteCharacterStatusEvent extends Equatable {
  const FavoriteCharacterStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteStatus extends FavoriteCharacterStatusEvent {
  final int id;

  const LoadFavoriteStatus({required this.id});

  @override
  List<Object> get props => [id];
}

class AddToFavorite extends FavoriteCharacterStatusEvent {
  final Character character;

  const AddToFavorite({required this.character});

  @override
  List<Object> get props => [character];
}

class RemoveFromFavorite extends FavoriteCharacterStatusEvent {
  final Character character;

  const RemoveFromFavorite({required this.character});

  @override
  List<Object> get props => [character];
}
