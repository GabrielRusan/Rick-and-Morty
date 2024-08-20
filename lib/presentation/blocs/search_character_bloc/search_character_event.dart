part of 'search_character_bloc.dart';

sealed class SearchCharacterEvent extends Equatable {
  const SearchCharacterEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchCharacterEvent {
  final String query;

  const OnQueryChanged({required this.query});

  @override
  List<Object> get props => [query];
}
