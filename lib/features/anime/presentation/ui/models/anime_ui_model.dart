import 'package:equatable/equatable.dart';

import '../../../domain/entities/anime.dart';

// ignore: must_be_immutable
class AnimeUiModel extends Equatable {
  AnimeUiModel({
    required this.anime,
    this.isVisible = true,
  });

  final Anime anime;
  bool isVisible;

  factory AnimeUiModel.fromEntity(Anime entity) {
    return AnimeUiModel(
      anime: entity,
      isVisible: true,
    );
  }

  AnimeUiModel copyWith({
    Anime? anime,
    bool? isVisible,
  }) {
    return AnimeUiModel(
      anime: anime ?? this.anime,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [anime, isVisible];
}
