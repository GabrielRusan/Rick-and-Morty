import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/usecases/get_all_characters.dart';
import 'package:rick_and_morty/utils/transformers.dart';

part 'all_characters_event.dart';
part 'all_characters_state.dart';

class AllCharactersBloc extends Bloc<AllCharactersEvent, AllCharactersState> {
  final GetAllCharacters _getAllCharacters;
  AllCharactersBloc(this._getAllCharacters)
      : super(const AllCharactersState(status: AllCharactersStatus.initial)) {
    on<FetchAllCharacters>(_onFetchAllCharacters,
        transformer: throttleDroppable(const Duration(milliseconds: 350)));
  }

  Future<void> _onFetchAllCharacters(
      FetchAllCharacters event, Emitter<AllCharactersState> emit) async {
    if (state.hasReachedMax) return;

    if (state.status == AllCharactersStatus.initial) {
      final result = await _getAllCharacters.execute();

      result.fold((failure) {
        emit(state.copyWith(status: AllCharactersStatus.failure));
      }, (data) {
        emit(state.copyWith(
            status: AllCharactersStatus.success, characters: data));
      });
      return;
    }

    final result = await _getAllCharacters.execute(
        page: state.characters.length ~/ 20 + 1);

    result.fold((failure) {
      emit(state.copyWith(status: AllCharactersStatus.failure));
    }, (data) {
      emit(data.isEmpty
          ? state.copyWith(
              status: AllCharactersStatus.success, hasReachedMax: true)
          : state.copyWith(
              status: AllCharactersStatus.success,
              hasReachedMax: false,
              characters: List.of(state.characters)..addAll(data)));
    });
  }
}
