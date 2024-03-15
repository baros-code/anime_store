import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/anime_genre.dart';

part 'anime_genre_model.g.dart';

@JsonSerializable()
class AnimeGenreModel {
  AnimeGenreModel({
    required this.name,
  });

  final String? name;

  factory AnimeGenreModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeGenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeGenreModelToJson(this);

  factory AnimeGenreModel.fromEntity(AnimeGenre entity) {
    return AnimeGenreModel(
      name: entity.name,
    );
  }

  AnimeGenre toEntity() {
    return AnimeGenre(
      name: name ?? 'N/A',
    );
  }
}
