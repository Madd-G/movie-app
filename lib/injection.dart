import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/src/home/data/datasources/datasources.dart';
import 'package:movies_app/src/home/data/repositories/genre_repository_impl.dart';
import 'package:movies_app/src/home/data/repositories/movie_repository_impl.dart';
import 'package:movies_app/src/home/domain/repositories/genre_repository.dart';
import 'package:movies_app/src/home/domain/repositories/movie_repository.dart';
import 'package:movies_app/src/home/domain/usecases/use_cases.dart';
import 'package:movies_app/src/home/presentation/blocs/blocs.dart';
import 'core/common/common.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initHelper();
  await _initBloc();
  await _initUseCase();
  await _initRepository();
  await _initDataSource();
  await _initNetworkInfo();
}

Future<void> _initBloc() async {
  sl
    ..registerFactory(() => MovieBloc(sl()))
    ..registerFactory(() => NowPlayingMoviesBloc(sl()))
    ..registerFactory(() => GenreBloc(sl()));
}

Future<void> _initUseCase() async {
  sl
    ..registerLazySingleton(() => GetMovies(sl()))
    ..registerLazySingleton(() => GetMoviesByGenre(sl()))
    ..registerLazySingleton(() => GetGenres(sl()));
}

Future<void> _initRepository() async {
  sl
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerLazySingleton<GenreRepository>(
      () => GenreRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
}

Future<void> _initDataSource() async {
  sl
    ..registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSourceImpl(client: sl()))
    ..registerLazySingleton<MovieLocalDataSource>(
        () => MovieLocalDataSourceImpl(databaseHelper: sl()))
    ..registerLazySingleton<GenreRemoteDataSource>(
        () => GenreRemoteDataSourceImpl(client: sl()))
    ..registerLazySingleton<GenreLocalDataSource>(
        () => GenreLocalDataSourceImpl(databaseHelper: sl()));
}

Future<void> _initHelper() async {
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}

Future<void> _initNetworkInfo() async {
  sl
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton(() => ApiService().client)
    ..registerLazySingleton(() => DataConnectionChecker());
}
