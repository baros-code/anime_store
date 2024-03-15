import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/anime_response.dart';
import '../../domain/entities/pagination.dart';
import 'anime_model.dart';
import 'pagination_model.dart';

part 'anime_response_model.g.dart';

@JsonSerializable()
class AnimeResponseModel {
  AnimeResponseModel({
    required this.pagination,
    required this.data,
  });

  final PaginationModel? pagination;
  final List<AnimeModel>? data;

  factory AnimeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeResponseModelToJson(this);

  factory AnimeResponseModel.fromEntity(AnimeResponse entity) {
    return AnimeResponseModel(
      pagination: PaginationModel.fromEntity(entity.pagination),
      data: entity.data.map(AnimeModel.fromEntity).toList(),
    );
  }

  AnimeResponse toEntity() {
    return AnimeResponse(
      pagination: pagination?.toEntity() ?? Pagination.nullValue(),
      data: data?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
