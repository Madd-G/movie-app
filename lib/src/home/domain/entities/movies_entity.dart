import 'package:equatable/equatable.dart';
import 'movie_entity.dart';

class MoviesEntity extends Equatable {
  final int? totalPages;
  final int? totalResults;
  final List<MovieEntity>? movies;

  const MoviesEntity({
    this.totalPages,
    this.totalResults,
    this.movies,
  });

  @override
  List<Object?> get props => [
        totalPages,
        totalResults,
        movies,
      ];

  @override
  String toString() {
    return 'Movies Entity { '
        '\n total_pages: $totalPages, '
        '\n total_results: $totalResults, '
        '\n results: $movies, '
        '\n}';
  }
}
