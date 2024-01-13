import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';
import 'package:movies_app/src/home/domain/repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<Either<Failure, List<MovieEntity>>> execute() => repository.getMovies();
}
