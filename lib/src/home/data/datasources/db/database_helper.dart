import 'dart:async';
import 'package:movies_app/src/home/data/models/genre_table.dart';
import 'package:movies_app/src/home/data/models/movie_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

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

  static const String _tblCacheMovie = 'cache_movie';
  static const String _tblCacheGenre = 'cache_genre';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/movie.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: 'movie',
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblCacheMovie (
        backdrop_path TEXT,
        title TEXT,
        release_date TEXT,
        poster_path TEXT,
        idCacheArticle INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblCacheGenre (
        id INTEGER,
        name TEXT,
        idCacheArticle INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');
  }

  Future<void> insertCacheTransactionMovies(
    List<MovieTable> articles,
    String category,
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final article in articles) {
        final articleJson = article.toJson();
        await txn.insert(_tblCacheMovie, articleJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheMovie,
    );

    return results;
  }

  Future<int> clearCacheMovies() async {
    final db = await database;
    return db!.delete(
      _tblCacheMovie,
    );
  }

  Future<void> insertCacheTransactionGenres(
    List<GenreTable> genres,
    String category,
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final genre in genres) {
        final genreJson = genre.toJson();
        await txn.insert(_tblCacheGenre, genreJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheGenres() async {
    final db = await database;
    final List<Map<String, dynamic>> genres = await db!.query(
      _tblCacheGenre,
    );

    return genres;
  }

  Future<int> clearCacheGenre() async {
    final db = await database;
    return db!.delete(
      _tblCacheGenre,
    );
  }
}
