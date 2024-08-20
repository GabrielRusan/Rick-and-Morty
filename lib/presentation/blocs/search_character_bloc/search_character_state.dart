part of 'search_character_bloc.dart';

sealed class SearchCharacterState extends Equatable {
  const SearchCharacterState();

  @override
  List<Object> get props => [];
}

final class SearchCharacterInitial extends SearchCharacterState {}

final class SearchCharacterEmpty extends SearchCharacterState {}

final class SearchCharacterLoading extends SearchCharacterState {}

final class SearchCharacterError extends SearchCharacterState {
  final String message;

  const SearchCharacterError(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchCharacterHasData extends SearchCharacterState {
  final List<Character> result;

  const SearchCharacterHasData({required this.result});

  @override
  List<Object> get props => [result];
}
