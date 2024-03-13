// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      lastPage: json['last_visible_page'] as int?,
      currentPage: json['current_page'] as int?,
      items:
          PaginationItemsModel.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'last_visible_page': instance.lastPage,
      'current_page': instance.currentPage,
      'items': instance.items,
    };
