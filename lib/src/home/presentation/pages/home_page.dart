import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/utils.dart';
import 'package:movies_app/src/home/presentation/blocs/genre_bloc/genre_bloc.dart';
import 'package:movies_app/src/home/presentation/blocs/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:movies_app/src/home/presentation/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getNowPlaying();
    getGenres();
  }

  void getNowPlaying() {
    context.read<NowPlayingMoviesBloc>().add(GetNowPlayingMoviesEvent());
  }

  void getGenres() {
    context.read<GenreBloc>().add(GetGenreEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text('The Movie List'),
        shadowColor: AppColors.greyColor,
        elevation: 1.0,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieCarousel(),
            GenreList(),
            MovieGrid(),
          ],
        ),
      ),
    );
  }
}
