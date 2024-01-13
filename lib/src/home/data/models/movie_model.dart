import 'package:equatable/equatable.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';

class MovieModel extends Equatable {
  final String? backdropPath;
  final String? title;
  final String? releaseDate;
  final String? posterPath;

  const MovieModel({
    this.backdropPath,
    this.title,
    this.releaseDate,
    this.posterPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        backdropPath: json["backdrop_path"],
        title: json["title"],
        releaseDate: json["release_date"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "title": title,
        "release_date": releaseDate,
        "poster_path": posterPath,
      };

  MovieEntity toEntity() {
    return MovieEntity(
      backdropPath: backdropPath,
      title: title,
      releaseDate: releaseDate,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        title,
        releaseDate,
        posterPath,
      ];
}
