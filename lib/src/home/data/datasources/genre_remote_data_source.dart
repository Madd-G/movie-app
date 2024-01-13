import 'dart:convert';
import 'dart:io';

import 'package:movies_app/core/constants/constants.dart';
import 'package:movies_app/core/errors/errors.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/home/data/models/genre_response.dart';

abstract class GenreRemoteDataSource {
  Future<GenreResponse> getGenres();
}

class GenreRemoteDataSourceImpl implements GenreRemoteDataSource {
  final http.Client client;

  GenreRemoteDataSourceImpl({required this.client});

  @override
  Future<GenreResponse> getGenres() async {
    final response = await client.get(
      Uri.parse('${baseUrl}genre/movie/list?api_key=$apiKey'),
      headers: {HttpHeaders.authorizationHeader: apiKey},
    );

    if (response.statusCode == 200) {
      return GenreResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }
}
