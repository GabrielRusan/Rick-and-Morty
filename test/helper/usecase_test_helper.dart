import 'package:mockito/annotations.dart';
import 'package:rick_and_morty/domain/usecases/get_all_characters.dart';
import 'package:rick_and_morty/domain/usecases/get_character_by_id.dart';
import 'package:rick_and_morty/domain/usecases/get_favorite_characters.dart';
import 'package:rick_and_morty/domain/usecases/get_favorite_status.dart';
import 'package:rick_and_morty/domain/usecases/insert_favorite.dart';
import 'package:rick_and_morty/domain/usecases/remove_favorite.dart';
import 'package:rick_and_morty/domain/usecases/search_character.dart';

@GenerateMocks([
  GetAllCharacters,
  GetCharacterById,
  GetFavoriteCharacters,
  GetFavoriteStatus,
  InsertFavorite,
  RemoveFavorite,
  SearchCharacter
])
void main() {}
