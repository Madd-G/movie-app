part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmptyState extends NowPlayingMoviesState {}

class NowPlayingMoviesLoadingState extends NowPlayingMoviesState {}

class NowPlayingMoviesLoadedState extends NowPlayingMoviesState {
  final List<MovieEntity> movies;

  const NowPlayingMoviesLoadedState(this.movies);

  @override
  List<Object> get props => [movies];
}

class NowPlayingMoviesErrorState extends NowPlayingMoviesState {
  final String message;

  const NowPlayingMoviesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
