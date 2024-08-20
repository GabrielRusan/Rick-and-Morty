part of 'all_characters_bloc.dart';

sealed class AllCharactersEvent extends Equatable {
  const AllCharactersEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllCharacters extends AllCharactersEvent {}
