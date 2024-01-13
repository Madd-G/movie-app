import 'package:equatable/equatable.dart';
import 'package:movies_app/src/home/domain/entities/genre_entity.dart';

class GenreModel extends Equatable {
  final int? id;
  final String? name;

  const GenreModel({
    this.id,
    this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  GenreEntity toEntity() {
    return GenreEntity(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
