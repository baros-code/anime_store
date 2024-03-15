import 'package:equatable/equatable.dart';

import 'anime_character.dart';

class AnimeCharacterResponse extends Equatable {
  const AnimeCharacterResponse({
    required this.character,
    required this.role,
    required this.favorites,
  });

  final AnimeCharacter character;
  final String role;
  final int favorites;

  @override
  List<Object?> get props => [character, role, favorites];
}
