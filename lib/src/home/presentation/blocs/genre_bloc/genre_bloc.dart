import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/home/domain/entities/genre_entity.dart';
import 'package:movies_app/src/home/domain/usecases/use_cases.dart';

part 'genre_event.dart';

part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GetGenres getGenres;
  int currentPage = 0;

  GenreBloc(this.getGenres) : super(GenreEmptyState()) {
    on<GetGenreEvent>((event, emit) async {
      emit(GenreLoadingState());
      final result = await getGenres.execute();
      result.fold((failure) => emit(GenreErrorState(failure.message)),
          (genresData) {
        emit(GenreLoadedState(genresData));
        if (genresData.isEmpty) {
          emit(GenreEmptyState());
        }
      });
    });
  }
}
