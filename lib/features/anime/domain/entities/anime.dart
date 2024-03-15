import 'package:equatable/equatable.dart';

import 'anime_genre.dart';
import 'custom_image.dart';

class Anime extends Equatable {
  const Anime({
    required this.id,
    required this.title,
    required this.images,
    required this.score,
    required this.episodes,
    required this.synopsis,
    required this.type,
    required this.genres,
  });

  final int id;
  final String title;
  final CustomImage images;
  final double score;
  final int episodes;
  final String synopsis;
  final String type;
  final List<AnimeGenre> genres;

  String get jpgUrl => images.jpg.imageUrl;

  String get allGenres => genres.map((e) => e.name).join(', ');

  @override
  List<Object> get props => [
        id,
        title,
        images,
        score,
        episodes,
        synopsis,
        type,
        genres,
      ];
}
