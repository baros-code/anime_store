import 'package:equatable/equatable.dart';

class AnimeGenre extends Equatable {
  const AnimeGenre({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}
