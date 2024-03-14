import '../../domain/entities/anime_character.dart';
import '../ui/models/anime_ui_model.dart';

abstract class AnimeState {}

class AnimeInitial extends AnimeState {}

class AnimeListFetched extends AnimeState {
  AnimeListFetched(this.animeList);

  final List<AnimeUiModel> animeList;
}

class AnimeListFetchFailed extends AnimeState {}

class AnimeCharactersLoading extends AnimeState {}

class AnimeCharactersFetched extends AnimeState {
  AnimeCharactersFetched(this.characters);

  final List<AnimeCharacter> characters;
}

class AnimeCharactersFetchFailed extends AnimeState {}
