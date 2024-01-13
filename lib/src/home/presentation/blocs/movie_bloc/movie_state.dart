part of 'movie_bloc.dart';

@immutable
abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MoviesEmptyState extends MovieState {}

class MoviesLoadingState extends MovieState {}

class MoviesLoadedState extends MovieState {
  final List<MovieEntity> movies;

  const MoviesLoadedState(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesErrorState extends MovieState {
  final String message;

  const MoviesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class MovieUpdatedState extends MovieState {
  const MovieUpdatedState();
}
