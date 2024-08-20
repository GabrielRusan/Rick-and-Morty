part of 'favorite_characters_bloc.dart';

sealed class FavoriteCharactersEvent extends Equatable {
  const FavoriteCharactersEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoriteCharacters extends FavoriteCharactersEvent {}
