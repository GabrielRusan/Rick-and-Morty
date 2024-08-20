import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/domain/usecases/get_character_by_id.dart';

part 'get_character_by_id_event.dart';
part 'get_character_by_id_state.dart';

class GetCharacterByIdBloc
    extends Bloc<GetCharacterByIdEvent, GetCharacterByIdState> {
  final GetCharacterById _getCharacterById;
  GetCharacterByIdBloc(this._getCharacterById)
      : super(GetCharacterByIdLoading()) {
    on<FetchCharacterById>((event, emit) async {
      emit(GetCharacterByIdLoading());
      final result = await _getCharacterById.execute(id: event.id);

      result.fold((failure) {
        emit(GetCharacterByIdError());
      }, (data) {
        emit(GetCharacterByIdLoaded(character: data));
      });
    });
  }
}
