import 'package:equatable/equatable.dart';
import 'package:movies_app/src/home/domain/entities/genre_entity.dart';

import 'genre_model.dart';

class GenreTable extends Equatable {
  final int? id;
  final String? name;

  const GenreTable({
    required this.id,
    required this.name,
  });

  factory GenreTable.fromEntity(GenreEntity genre) => GenreTable(
        id: genre.id,
        name: genre.name,
      );

  factory GenreTable.fromMap(Map<String, dynamic> map) => GenreTable(
        id: map['id'],
        name: map['name'],
      );

  factory GenreTable.fromDTO(GenreModel genre) => GenreTable(
        id: genre.id,
        name: genre.name,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  GenreEntity toEntity() => GenreEntity.bookmark(
        id: id,
        name: name,
      );

  @override
  List<Object?> get props => [id, name];
}
