// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeCharacterModel _$AnimeCharacterModelFromJson(Map<String, dynamic> json) =>
    AnimeCharacterModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      images: json['images'] == null
          ? null
          : CustomImageModel.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeCharacterModelToJson(
        AnimeCharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
    };
