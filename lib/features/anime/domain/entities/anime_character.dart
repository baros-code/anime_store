import 'package:equatable/equatable.dart';

import 'custom_image.dart';

class AnimeCharacter extends Equatable {
  const AnimeCharacter({
    required this.id,
    required this.name,
    required this.images,
  });

  final int id;
  final String name;
  final CustomImage images;

  static AnimeCharacter nullValue() {
    return AnimeCharacter(
      id: -1,
      name: 'N/A',
      images: CustomImage.nullValue(),
    );
  }

  @override
  List<Object?> get props => [id, name, images];
}
