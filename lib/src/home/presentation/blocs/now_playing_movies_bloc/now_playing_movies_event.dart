part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesEvent {}

class GetNowPlayingMoviesEvent extends NowPlayingMoviesEvent {}