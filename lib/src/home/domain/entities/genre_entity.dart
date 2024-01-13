import 'package:equatable/equatable.dart';

class GenresEntity extends Equatable {
  final List<GenreEntity>? genres;

  const GenresEntity({
    this.genres,
  });

  @override
  List<Object?> get props => [
        genres,
      ];

  @override
  String toString() {
    return 'Genre Entity { '
        '\n results: $genres, '
        '\n}';
  }
}

class GenreEntity extends Equatable {
  const GenreEntity({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  const GenreEntity.bookmark({this.id, this.name});

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  @override
  String toString() {
    return 'Genre Entity { '
        '\n id: $id, '
        '\n name: $name, '
        '\n}';
  }
}
