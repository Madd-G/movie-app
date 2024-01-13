import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:movies_app/src/home/domain/entities/genre_entity.dart';

abstract class GenreRepository {
  Future<Either<Failure, List<GenreEntity>>> getGenres();
}
