// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeModel _$AnimeModelFromJson(Map<String, dynamic> json) => AnimeModel(
      id: json['mal_id'] as int?,
      title: json['title'] as String?,
      images: json['images'] == null
          ? null
          : CustomImageModel.fromJson(json['images'] as Map<String, dynamic>),
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AnimeModelToJson(AnimeModel instance) =>
    <String, dynamic>{
      'mal_id': instance.id,
      'title': instance.title,
      'images': instance.images,
      'score': instance.score,
    };
