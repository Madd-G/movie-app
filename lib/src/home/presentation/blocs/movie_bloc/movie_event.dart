part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class GetMoviesByGenreEvent extends MovieEvent {
  final int id;

  GetMoviesByGenreEvent({required this.id});
}

class ChangeMoviesByGenreEvent extends MovieEvent {
  final int id;

  ChangeMoviesByGenreEvent({required this.id});
}
