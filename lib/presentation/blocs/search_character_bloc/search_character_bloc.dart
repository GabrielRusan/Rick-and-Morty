import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/usecases/search_character.dart';
import 'package:rick_and_morty/utils/failure.dart';
import 'package:rick_and_morty/utils/transformers.dart';

part 'search_character_event.dart';
part 'search_character_state.dart';

class SearchCharacterBloc
    extends Bloc<SearchCharacterEvent, SearchCharacterState> {
  final SearchCharacter searchCharacter;
  SearchCharacterBloc(this.searchCharacter) : super(SearchCharacterInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchCharacterLoading());
      final result = await searchCharacter.execute(name: query);

      result.fold((failure) {
        if (failure is NotFoundFailure) {
          emit(SearchCharacterEmpty());
        } else {
          emit(SearchCharacterError(failure.message));
        }
      }, (characterList) {
        emit(SearchCharacterHasData(result: characterList));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
