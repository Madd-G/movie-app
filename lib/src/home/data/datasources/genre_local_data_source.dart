import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/data/models/genre_table.dart';

import 'db/database_helper.dart';

abstract class GenreLocalDataSource {
  Future<void> cacheGenres(List<GenreTable> genres);

  Future<List<GenreTable>> getCachedGenres();
}

class GenreLocalDataSourceImpl implements GenreLocalDataSource {
  final DatabaseHelper databaseHelper;

  GenreLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheGenres(List<GenreTable> genres) async {
    await databaseHelper.clearCacheGenre();
    await databaseHelper.insertCacheTransactionGenres(genres, 'genres');
  }

  @override
  Future<List<GenreTable>> getCachedGenres() async {
    final result = await databaseHelper.getCacheGenres();
    if (result.isNotEmpty) {
      return result.map((data) => GenreTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data");
    }
  }
}
