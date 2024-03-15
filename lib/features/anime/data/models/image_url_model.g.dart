// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUrlModel _$ImageUrlModelFromJson(Map<String, dynamic> json) =>
    ImageUrlModel(
      imageUrl: json['image_url'] as String?,
      smallImageUrl: json['small_image_url'] as String?,
    );

Map<String, dynamic> _$ImageUrlModelToJson(ImageUrlModel instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
      'small_image_url': instance.smallImageUrl,
    };
