// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeResponseModel _$AnimeResponseModelFromJson(Map<String, dynamic> json) =>
    AnimeResponseModel(
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AnimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimeResponseModelToJson(AnimeResponseModel instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'data': instance.data,
    };
