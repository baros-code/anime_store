import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/pagination.dart';
import 'pagination_items_model.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class PaginationModel {
  PaginationModel({
    required this.lastPage,
    required this.currentPage,
    required this.items,
  });

  @JsonKey(name: 'last_visible_page')
  final int? lastPage;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final PaginationItemsModel items;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  factory PaginationModel.fromEntity(Pagination entity) {
    return PaginationModel(
      lastPage: entity.lastPage,
      currentPage: entity.currentPage,
      items: PaginationItemsModel.fromEntity(entity.items),
    );
  }

  Pagination toEntity() {
    return Pagination(
      lastPage: lastPage ?? -1,
      currentPage: currentPage ?? -1,
      items: items.toEntity(),
    );
  }
}
