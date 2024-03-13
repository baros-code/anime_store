import 'package:equatable/equatable.dart';

import 'pagination_items.dart';

class Pagination extends Equatable {
  const Pagination({
    required this.lastPage,
    required this.currentPage,
    required this.items,
  });

  final int lastPage;
  final int currentPage;
  final PaginationItems items;

  static Pagination nullValue() {
    return Pagination(
      lastPage: -1,
      currentPage: -1,
      items: PaginationItems.nullValue(),
    );
  }

  @override
  List<Object> get props => [lastPage, currentPage];
}
