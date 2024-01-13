part of 'genre_bloc.dart';

@immutable
abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreEmptyState extends GenreState {}

class GenreLoadingState extends GenreState {}

class GenreLoadedState extends GenreState {
  final List<GenreEntity> genres;

  const GenreLoadedState(this.genres);

  @override
  List<Object> get props => [genres];
}

class GenreErrorState extends GenreState {
  final String message;

  const GenreErrorState(this.message);

  @override
  List<Object> get props => [message];
}
