import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';
import 'package:movies_app/src/home/domain/repositories/movie_repository.dart';

class GetMoviesByGenre {
  final MovieRepository repository;

  GetMoviesByGenre(this.repository);

  Future<Either<Failure, List<MovieEntity>>> execute(int id) =>
      repository.getMovieByCategory(id);
}
