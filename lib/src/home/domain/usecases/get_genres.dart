import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/domain/entities/genre_entity.dart';
import 'package:movies_app/src/home/domain/repositories/genre_repository.dart';

class GetGenres {
  final GenreRepository repository;

  GetGenres(this.repository);

  Future<Either<Failure, List<GenreEntity>>> execute() =>
      repository.getGenres();
}
