// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_character_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeCharacterResponseModel _$AnimeCharacterResponseModelFromJson(
        Map<String, dynamic> json) =>
    AnimeCharacterResponseModel(
      character: json['character'] == null
          ? null
          : AnimeCharacterModel.fromJson(
              json['character'] as Map<String, dynamic>),
      role: json['role'] as String?,
      favorites: json['favorites'] as int?,
    );

Map<String, dynamic> _$AnimeCharacterResponseModelToJson(
        AnimeCharacterResponseModel instance) =>
    <String, dynamic>{
      'character': instance.character,
      'role': instance.role,
      'favorites': instance.favorites,
    };
