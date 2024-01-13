import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies();

  Future<Either<Failure, List<MovieEntity>>> getMovieByCategory(int id);
}
