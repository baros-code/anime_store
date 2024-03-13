// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomImageModel _$CustomImageModelFromJson(Map<String, dynamic> json) =>
    CustomImageModel(
      jpg: json['jpg'] == null
          ? null
          : ImageUrlModel.fromJson(json['jpg'] as Map<String, dynamic>),
      webp: json['webp'] == null
          ? null
          : ImageUrlModel.fromJson(json['webp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomImageModelToJson(CustomImageModel instance) =>
    <String, dynamic>{
      'jpg': instance.jpg,
      'webp': instance.webp,
    };
