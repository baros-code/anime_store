import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/anime.dart';
import '../../domain/entities/custom_image.dart';
import 'custom_image_model.dart';

part 'anime_model.g.dart';

@JsonSerializable()
class AnimeModel {
  AnimeModel({
    required this.id,
    required this.title,
    required this.images,
    required this.score,
  });

  @JsonKey(name: 'mal_id')
  final int? id;
  final String? title;
  final CustomImageModel? images;
  final double? score;

  factory AnimeModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeModelToJson(this);

  factory AnimeModel.fromEntity(Anime entity) {
    return AnimeModel(
      id: entity.id,
      title: entity.title,
      images: CustomImageModel.fromEntity(entity.images),
      score: entity.score,
    );
  }

  Anime toEntity() {
    return Anime(
      id: id ?? -1,
      title: title ?? 'N/A',
      images: images?.toEntity() ?? CustomImage.nullValue(),
      score: score ?? 0,
    );
  }
}
