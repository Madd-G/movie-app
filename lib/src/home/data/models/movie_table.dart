import 'package:equatable/equatable.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';

import 'movie_model.dart';

class MovieTable extends Equatable {
  final String? backdropPath;
  final String? title;
  final String? releaseDate;
  final String? posterPath;

  const MovieTable({
    required this.backdropPath,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
  });

  factory MovieTable.fromEntity(MovieEntity movie) => MovieTable(
        backdropPath: movie.backdropPath,
        title: movie.title,
        releaseDate: movie.releaseDate,
        posterPath: movie.posterPath,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        backdropPath: map['backdrop_path'],
        title: map['title'],
        releaseDate: map['release_date'],
        posterPath: map['poster_path'],
      );

  factory MovieTable.fromDTO(MovieModel movie) => MovieTable(
        backdropPath: movie.backdropPath,
        title: movie.title,
        releaseDate: movie.releaseDate,
        posterPath: movie.posterPath,
      );

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'title': title,
        'release_date': releaseDate,
        'poster_path': posterPath,
      };

  MovieEntity toEntity() => MovieEntity.bookmark(
        backdropPath: backdropPath,
        title: title,
        releaseDate: releaseDate,
        posterPath: posterPath,
      );

  @override
  List<Object?> get props => [
        backdropPath,
        title,
        releaseDate,
        posterPath,
      ];
}
