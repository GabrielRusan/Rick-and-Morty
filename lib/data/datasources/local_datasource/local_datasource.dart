import 'package:rick_and_morty/data/datasources/local_datasource/db/database_helper.dart';
import 'package:rick_and_morty/data/models/character_table.dart';
import 'package:rick_and_morty/utils/exception.dart';

abstract class LocalDataSource {
  Future<String> insertFavorite(CharacterTable character);
  Future<String> removeFavorite(CharacterTable character);
  Future<List<CharacterTable>> getFavoriteCharacters();
  Future<CharacterTable?> getCharacterById(int id);
}

class LocalDataSourceImpl implements LocalDataSource {
  final DatabaseHelper databaseHelper;

  const LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertFavorite(CharacterTable character) async {
    try {
      await databaseHelper.insertFavorite(character);
      return 'Added to Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(CharacterTable character) async {
    try {
      await databaseHelper.removeFavorite(character);
      return 'Removed from Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<CharacterTable>> getFavoriteCharacters() async {
    final result = await databaseHelper.getFavoriteCharacters();
    return result.map((data) => CharacterTable.fromMap(data)).toList();
  }

  @override
  Future<CharacterTable?> getCharacterById(int id) async {
    final result = await databaseHelper.getCharacterById(id);
    if (result != null) {
      return CharacterTable.fromMap(result);
    } else {
      return null;
    }
  }
}
