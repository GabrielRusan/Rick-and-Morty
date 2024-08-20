import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/usecases/get_favorite_status.dart';
import 'package:rick_and_morty/domain/usecases/insert_favorite.dart';
import 'package:rick_and_morty/domain/usecases/remove_favorite.dart';
import 'package:rick_and_morty/utils/transformers.dart';

part 'favorite_character_status_event.dart';
part 'favorite_character_status_state.dart';

class FavoriteCharacterStatusBloc
    extends Bloc<FavoriteCharacterStatusEvent, FavoriteCharacterStatusState> {
  final GetFavoriteStatus _getFavoriteStatus;
  final InsertFavorite _insertFavorite;
  final RemoveFavorite _removeFavorite;
  FavoriteCharacterStatusBloc(
      this._getFavoriteStatus, this._insertFavorite, this._removeFavorite)
      : super(const FavoriteCharacterStatusLoaded(isAddedToFavorite: false)) {
    on<LoadFavoriteStatus>(_onLoadFavoriteStatus);
    on<AddToFavorite>(_onAddToFavorite,
        transformer: throttleDroppable(const Duration(seconds: 1)));
    on<RemoveFromFavorite>(_onRemoveFromFavorite,
        transformer: throttleDroppable(const Duration(seconds: 1)));
  }

  Future<void> _onLoadFavoriteStatus(LoadFavoriteStatus event,
      Emitter<FavoriteCharacterStatusState> emit) async {
    final status = await _getFavoriteStatus.execute(event.id);
    emit(FavoriteCharacterStatusLoaded(isAddedToFavorite: status));
  }

  Future<void> _onAddToFavorite(
      AddToFavorite event, Emitter<FavoriteCharacterStatusState> emit) async {
    final result = await _insertFavorite.execute(event.character);

    result.fold((failure) {
      emit(FailAddCharacter());
    }, (message) {
      emit(SuccessAddCharacter());
    });

    add(LoadFavoriteStatus(id: event.character.id));
  }

  Future<void> _onRemoveFromFavorite(RemoveFromFavorite event,
      Emitter<FavoriteCharacterStatusState> emit) async {
    final result = await _removeFavorite.execute(event.character);

    result.fold((failure) {
      emit(FailRemoveCharacter());
    }, (message) {
      emit(SuccessRemoveCharacter());
    });

    add(LoadFavoriteStatus(id: event.character.id));
  }
}
