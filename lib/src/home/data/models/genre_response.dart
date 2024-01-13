import 'package:equatable/equatable.dart';
import 'package:movies_app/src/home/domain/entities/genre_entity.dart';
import 'genre_model.dart';

class GenreResponse extends Equatable {
  final List<GenreModel>? genres;

  const GenreResponse({
    this.genres,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
        genres: json["genres"] == null
            ? null
            : List<GenreModel>.from(
                json["genres"].map((x) => GenreModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
      };

  GenresEntity toEntity() {
    return GenresEntity(
      genres: genres?.map((x) => x.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [genres];
}
