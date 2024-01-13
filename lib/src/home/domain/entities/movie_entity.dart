import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    this.backdropPath,
    this.title,
    this.releaseDate,
    this.posterPath,
  });

  final String? backdropPath;
  final String? title;
  final String? releaseDate;
  final String? posterPath;

  const MovieEntity.bookmark({
    this.backdropPath,
    this.title,
    this.releaseDate,
    this.posterPath,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        title,
        releaseDate,
        posterPath,
      ];

  @override
  String toString() {
    return 'Movie Entity { '
        '\n backdrop_path: $backdropPath, '
        '\n title: $title, '
        '\n release_date: $releaseDate, '
        '\n}';
  }
}
