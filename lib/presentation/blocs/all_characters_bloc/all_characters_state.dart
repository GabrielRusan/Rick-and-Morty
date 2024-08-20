part of 'all_characters_bloc.dart';

enum AllCharactersStatus { initial, success, failure }

final class AllCharactersState extends Equatable {
  const AllCharactersState({
    this.status = AllCharactersStatus.initial,
    this.characters = const <Character>[],
    this.hasReachedMax = false,
  });

  final AllCharactersStatus status;
  final List<Character> characters;
  final bool hasReachedMax;

  AllCharactersState copyWith({
    AllCharactersStatus? status,
    List<Character>? characters,
    bool? hasReachedMax,
  }) {
    return AllCharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, characters, hasReachedMax];
}
