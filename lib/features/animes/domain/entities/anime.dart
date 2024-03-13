import 'package:equatable/equatable.dart';

import 'custom_image.dart';

class Anime extends Equatable {
  const Anime({
    required this.id,
    required this.title,
    required this.images,
    required this.score,
  });

  final int id;
  final String title;
  final CustomImage images;
  final double score;

  String get jpgUrl => images.jpg.imageUrl;

  @override
  List<Object> get props => [id, title, images, score];
}
