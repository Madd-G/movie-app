import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';
import 'package:movies_app/src/home/domain/usecases/use_cases.dart';

part 'now_playing_movies_event.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetMovies getMovies;

  NowPlayingMoviesBloc(this.getMovies) : super(NowPlayingMoviesEmptyState()) {
    on<GetNowPlayingMoviesEvent>(
      (event, emit) async {
        emit(NowPlayingMoviesLoadingState());
        final result = await getMovies.execute();
        result.fold(
          (failure) => emit(NowPlayingMoviesErrorState(failure.message)),
          (moviesData) {
            emit(NowPlayingMoviesLoadedState(moviesData));
            if (moviesData.isEmpty) {
              emit(NowPlayingMoviesEmptyState());
            }
          },
        );
      },
    );
  }
}
