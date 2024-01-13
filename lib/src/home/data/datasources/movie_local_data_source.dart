import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/data/models/movie_table.dart';

import 'db/database_helper.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovies(List<MovieTable> movies);

  Future<List<MovieTable>> getCachedMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCacheMovies();
    await databaseHelper.insertCacheTransactionMovies(movies, 'articles');
  }

  @override
  Future<List<MovieTable>> getCachedMovies() async {
    final result = await databaseHelper.getCacheMovies();
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data");
    }
  }
}
