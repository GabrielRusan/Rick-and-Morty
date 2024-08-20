part of 'favorite_character_status_bloc.dart';

sealed class FavoriteCharacterStatusState extends Equatable {
  const FavoriteCharacterStatusState();

  @override
  List<Object> get props => [];
}

final class FavoriteCharacterStatusInitial
    extends FavoriteCharacterStatusState {}

final class FavoriteCharacterStatusLoaded extends FavoriteCharacterStatusState {
  final bool isAddedToFavorite;

  const FavoriteCharacterStatusLoaded({required this.isAddedToFavorite});

  @override
  List<Object> get props => [isAddedToFavorite];
}

final class SuccessAddCharacter extends FavoriteCharacterStatusState {
  final String message = 'Added to Favorite';
}

final class FailAddCharacter extends FavoriteCharacterStatusState {
  final String message = 'Failed Adding Character to Favorite';
}

final class SuccessRemoveCharacter extends FavoriteCharacterStatusState {
  final String message = 'Removed from Favorite';
}

final class FailRemoveCharacter extends FavoriteCharacterStatusState {
  final String message = 'Failed to Remove Character from Favorite';
}
