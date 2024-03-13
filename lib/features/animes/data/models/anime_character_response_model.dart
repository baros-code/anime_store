import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/anime_character.dart';
import '../../domain/entities/anime_character_response.dart';
import 'anime_character_model.dart';

part 'anime_character_response_model.g.dart';

@JsonSerializable()
class AnimeCharacterResponseModel {
  AnimeCharacterResponseModel({
    required this.character,
    required this.role,
    required this.favorites,
  });

  final AnimeCharacterModel? character;
  final String? role;
  final int? favorites;

  factory AnimeCharacterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeCharacterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeCharacterResponseModelToJson(this);

  factory AnimeCharacterResponseModel.fromEntity(
    AnimeCharacterResponse entity,
  ) {
    return AnimeCharacterResponseModel(
      character: AnimeCharacterModel.fromEntity(entity.character),
      role: entity.role,
      favorites: entity.favorites,
    );
  }

  AnimeCharacterResponse toEntity() {
    return AnimeCharacterResponse(
      character: character?.toEntity() ?? AnimeCharacter.nullValue(),
      role: role ?? 'N/A',
      favorites: favorites ?? -1,
    );
  }
}
