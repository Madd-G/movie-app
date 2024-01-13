import 'package:dartz/dartz.dart';
import 'package:movies_app/core/common/common.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/data/datasources/genre_local_data_source.dart';
import 'package:movies_app/src/home/data/datasources/genre_remote_data_source.dart';
import 'package:movies_app/src/home/data/models/genre_response.dart';
import 'package:movies_app/src/home/data/models/genre_table.dart';
import 'package:movies_app/src/home/domain/entities/genre_entity.dart';
import 'package:movies_app/src/home/domain/repositories/genre_repository.dart';

class GenreRepositoryImpl implements GenreRepository {
  final GenreRemoteDataSource remoteDataSource;
  final GenreLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GenreRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenres() async {
    if (await networkInfo.isConnected) {
      try {
        GenreResponse result = await remoteDataSource.getGenres();
        localDataSource.cacheGenres(
          result.genres?.map((genre) => GenreTable.fromDTO(genre)).toList() ??
              [],
        );
        return Right(
            result.genres?.map((model) => model.toEntity()).toList() ?? []);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final result = await localDataSource.getCachedGenres();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}
