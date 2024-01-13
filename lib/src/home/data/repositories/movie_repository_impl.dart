import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/common/common.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/data/datasources/movie_local_data_source.dart';
import 'package:movies_app/src/home/data/datasources/movie_remote_data_source.dart';
import 'package:movies_app/src/home/data/models/movie_response.dart';
import 'package:movies_app/src/home/data/models/movie_table.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';
import 'package:movies_app/src/home/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovies() async {
    if (await networkInfo.isConnected) {
      try {
        MovieResponse result = await remoteDataSource.getMovies();
        localDataSource.cacheMovies(
          result.movies?.map((movie) => MovieTable.fromDTO(movie)).toList() ??
              [],
        );
        return Right(
            result.movies?.map((model) => model.toEntity()).toList() ?? []);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final result = await localDataSource.getCachedMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovieByCategory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        MovieResponse result = await remoteDataSource.getMovieByGenre(id);
        return Right(
          result.movies?.map((model) => model.toEntity()).toList() ?? [],
        );
      } on ServerException {
        return const Left(ServerFailure('Failed to connect to the server'));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}
