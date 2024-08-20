import 'dart:async';

import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblFavorite = 'favorite';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/rick_and_morty.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblFavorite (
        id INTEGER PRIMARY KEY,
        name TEXT,
        image TEXT,
        originName TEXT
      );
    ''');
  }

  Future<int> insertFavorite(CharacterModel character) async {
    final db = await database;
    return await db!.insert(_tblFavorite, {
      "id": character.id,
      "name": character.name,
      "image": character.image,
      "originName": character.origin.name,
    });
  }

  Future<int> removeWatchlistTv(CharacterModel character) async {
    final db = await database;
    return await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [character.id],
    );
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvs() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results;
  }

  Future<Map<String, dynamic>?> getCharacterById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
