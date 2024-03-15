import 'package:equatable/equatable.dart';

import 'anime.dart';
import 'pagination.dart';

class AnimeResponse extends Equatable {
  const AnimeResponse({
    required this.pagination,
    required this.data,
  });

  final Pagination pagination;
  final List<Anime> data;

  @override
  List<Object> get props => [pagination, data];
}
