import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/anime.dart';
import '../../domain/entities/custom_image.dart';
import 'anime_genre_model.dart';
import 'custom_image_model.dart';

part 'anime_model.g.dart';

@JsonSerializable()
class AnimeModel {
  AnimeModel({
    required this.id,
    required this.title,
    required this.images,
    required this.score,
    required this.episodes,
    required this.synopsis,
    required this.type,
    required this.genres,
  });

  @JsonKey(name: 'mal_id')
  final int? id;
  final String? title;
  final CustomImageModel? images;
  final double? score;
  final int? episodes;
  final String? synopsis;
  final String? type;
  final List<AnimeGenreModel>? genres;

  factory AnimeModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeModelToJson(this);

  factory AnimeModel.fromEntity(Anime entity) {
    return AnimeModel(
      id: entity.id,
      title: entity.title,
      images: CustomImageModel.fromEntity(entity.images),
      score: entity.score,
      episodes: entity.episodes,
      synopsis: entity.synopsis,
      type: entity.type,
      genres: entity.genres.map((e) => AnimeGenreModel.fromEntity(e)).toList(),
    );
  }

  Anime toEntity() {
    return Anime(
      id: id ?? -1,
      title: title ?? 'N/A',
      images: images?.toEntity() ?? CustomImage.nullValue(),
      score: score ?? 0,
      episodes: episodes ?? 0,
      synopsis: synopsis ?? 'N/A',
      type: type ?? 'N/A',
      genres: genres?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
