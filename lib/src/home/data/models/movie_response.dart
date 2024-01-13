import 'package:equatable/equatable.dart';
import 'package:movies_app/src/home/domain/entities/movies_entity.dart';

import 'movie_model.dart';

class MovieResponse extends Equatable {
  final int? totalPages;
  final int? totalResults;
  final List<MovieModel>? movies;

  const MovieResponse({
    this.totalPages,
    this.totalResults,
    this.movies,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        movies: json["results"] == null
            ? null
            : List<MovieModel>.from(
                json["results"].map((x) => MovieModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "total_results": totalResults,
        "results": movies == null
            ? null
            : List<dynamic>.from(movies!.map((x) => x.toJson())),
      };

  MoviesEntity toEntity() {
    return MoviesEntity(
      totalPages: totalPages,
      totalResults: totalResults,
      movies: movies?.map((x) => x.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        totalPages,
        totalResults,
        movies,
      ];
}
