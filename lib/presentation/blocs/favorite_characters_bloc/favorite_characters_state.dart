part of 'favorite_characters_bloc.dart';

sealed class FavoriteCharacterState extends Equatable {
  const FavoriteCharacterState();

  @override
  List<Object> get props => [];
}

final class FavoriteCharacterEmpty extends FavoriteCharacterState {}

final class FavoriteCharacterLoading extends FavoriteCharacterState {}

final class FavoriteCharacterError extends FavoriteCharacterState {}

final class FavoriteCharacterHasData extends FavoriteCharacterState {
  final List<Character> result;

  const FavoriteCharacterHasData({required this.result});

  @override
  List<Object> get props => [result];
}
