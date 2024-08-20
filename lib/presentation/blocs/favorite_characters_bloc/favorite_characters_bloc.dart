import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/usecases/get_favorite_characters.dart';

part 'favorite_characters_event.dart';
part 'favorite_characters_state.dart';

class FavoriteCharacterBloc
    extends Bloc<FavoriteCharactersEvent, FavoriteCharacterState> {
  final GetFavoriteCharacters _getFavoriteCharacter;
  FavoriteCharacterBloc(this._getFavoriteCharacter)
      : super(FavoriteCharacterLoading()) {
    on<FetchFavoriteCharacters>((event, emit) async {
      emit(FavoriteCharacterLoading());

      final result = await _getFavoriteCharacter.execute();

      result.fold((failure) {
        emit(FavoriteCharacterError());
      }, (characters) {
        if (characters.isEmpty) {
          emit(FavoriteCharacterEmpty());
        } else {
          emit(FavoriteCharacterHasData(result: characters));
        }
      });
    });
  }
}
