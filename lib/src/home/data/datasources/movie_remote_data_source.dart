import 'dart:convert';
import 'dart:io';

import 'package:movies_app/core/constants/constants.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/home/data/models/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponse> getMovies();

  Future<MovieResponse> getMovieByGenre(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<MovieResponse> getMovies() async {
    final response = await client.get(
      Uri.parse(
          '${baseUrl}movie/now_playing?api_key=$apiKey&language=en-US&page=1'),
      headers: {HttpHeaders.authorizationHeader: apiKey},
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }

  @override
  Future<MovieResponse> getMovieByGenre(int id) async {
    final response = await client.get(
      Uri.parse('${baseUrl}discover/movie?api_key=$apiKey&with_genres=$id'),
      headers: {HttpHeaders.authorizationHeader: apiKey},
    );

    // https://api.themoviedb.org/3/discover/movie?with_genres=37
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }
}
