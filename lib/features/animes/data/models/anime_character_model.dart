import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/anime_character.dart';
import '../../domain/entities/custom_image.dart';
import 'custom_image_model.dart';

part 'anime_character_model.g.dart';

@JsonSerializable()
class AnimeCharacterModel {
  AnimeCharacterModel({
    required this.id,
    required this.name,
    required this.images,
  });

  final int? id;
  final String? name;
  final CustomImageModel? images;

  factory AnimeCharacterModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeCharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeCharacterModelToJson(this);

  factory AnimeCharacterModel.fromEntity(AnimeCharacter entity) {
    return AnimeCharacterModel(
      id: entity.id,
      name: entity.name,
      images: CustomImageModel.fromEntity(entity.images),
    );
  }

  AnimeCharacter toEntity() {
    return AnimeCharacter(
      id: id ?? -1,
      name: name ?? 'N/A',
      images: images?.toEntity() ?? CustomImage.nullValue(),
    );
  }
}
