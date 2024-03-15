import 'package:equatable/equatable.dart';

class PaginationItems extends Equatable {
  const PaginationItems({
    required this.total,
  });

  final int total;

  static PaginationItems nullValue() {
    return const PaginationItems(
      total: -1,
    );
  }

  @override
  List<Object?> get props => [total];
}
