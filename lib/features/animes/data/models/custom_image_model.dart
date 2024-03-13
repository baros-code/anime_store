import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/custom_image.dart';
import '../../domain/entities/image_url.dart';
import 'image_url_model.dart';

part 'custom_image_model.g.dart';

@JsonSerializable()
class CustomImageModel {
  CustomImageModel({
    required this.jpg,
    required this.webp,
  });

  final ImageUrlModel? jpg;
  final ImageUrlModel? webp;

  factory CustomImageModel.fromJson(Map<String, dynamic> json) =>
      _$CustomImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomImageModelToJson(this);

  factory CustomImageModel.fromEntity(CustomImage entity) {
    return CustomImageModel(
      jpg: ImageUrlModel.fromEntity(entity.jpg),
      webp: ImageUrlModel.fromEntity(entity.webp),
    );
  }

  CustomImage toEntity() {
    return CustomImage(
      jpg: jpg?.toEntity() ?? ImageUrl.nullValue(),
      webp: webp?.toEntity() ?? ImageUrl.nullValue(),
    );
  }
}
