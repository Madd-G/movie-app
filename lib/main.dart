import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/home/presentation/blocs/genre_bloc/genre_bloc.dart';
import 'package:movies_app/src/home/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:movies_app/src/home/presentation/blocs/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:movies_app/src/home/presentation/pages/home_page.dart';
import 'package:movies_app/injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MovieBloc>()),
        BlocProvider(create: (_) => sl<NowPlayingMoviesBloc>()),
        BlocProvider(create: (_) => sl<GenreBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
