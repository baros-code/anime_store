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
      episodes: json['episodes'] as int?,
      synopsis: json['synopsis'] as String?,
      type: json['type'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => AnimeGenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimeModelToJson(AnimeModel instance) =>
    <String, dynamic>{
      'mal_id': instance.id,
      'title': instance.title,
      'images': instance.images,
      'score': instance.score,
      'episodes': instance.episodes,
      'synopsis': instance.synopsis,
      'type': instance.type,
      'genres': instance.genres,
    };
