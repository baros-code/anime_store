import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/pagination_items.dart';

part 'pagination_items_model.g.dart';

@JsonSerializable()
class PaginationItemsModel {
  PaginationItemsModel({
    required this.total,
  });

  final int? total;

  factory PaginationItemsModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationItemsModelToJson(this);

  factory PaginationItemsModel.fromEntity(PaginationItems entity) {
    return PaginationItemsModel(
      total: entity.total,
    );
  }

  PaginationItems toEntity() {
    return PaginationItems(
      total: total ?? -1,
    );
  }
}
