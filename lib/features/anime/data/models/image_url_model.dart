import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/image_url.dart';

part 'image_url_model.g.dart';

@JsonSerializable()
class ImageUrlModel {
  ImageUrlModel({
    required this.imageUrl,
    required this.smallImageUrl,
  });

  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'small_image_url')
  final String? smallImageUrl;

  factory ImageUrlModel.fromJson(Map<String, dynamic> json) =>
      _$ImageUrlModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUrlModelToJson(this);

  factory ImageUrlModel.fromEntity(ImageUrl entity) {
    return ImageUrlModel(
      imageUrl: entity.imageUrl,
      smallImageUrl: entity.smallImageUrl,
    );
  }

  ImageUrl toEntity() {
    return ImageUrl(
      imageUrl: imageUrl ?? 'N/A',
      smallImageUrl: smallImageUrl ?? 'N/A',
    );
  }
}
