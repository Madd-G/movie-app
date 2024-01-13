import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';
import 'package:movies_app/src/home/domain/usecases/get_movies_by_genre.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesByGenre getMoviesByGenre;

  MovieBloc(this.getMoviesByGenre) : super(MoviesEmptyState()) {
    on<GetMoviesByGenreEvent>(
      (event, emit) async {
        emit(MoviesLoadingState());
        final result = await getMoviesByGenre.execute(event.id);
        result.fold(
          (failure) => emit(MoviesErrorState(failure.message)),
          (moviesData) {
            emit(MoviesLoadedState(moviesData));
            if (moviesData.isEmpty) {
              emit(MoviesEmptyState());
            }
          },
        );
      },
    );

    on<ChangeMoviesByGenreEvent>(
      (event, emit) async {
        emit(MoviesLoadingState());
        final result = await getMoviesByGenre.execute(event.id);
        result.fold(
          (failure) => emit(MoviesErrorState(failure.message)),
          (moviesData) {
            emit(MoviesLoadedState(moviesData));
            if (moviesData.isEmpty) {
              emit(MoviesEmptyState());
            }
          },
        );
      },
    );
  }
}
