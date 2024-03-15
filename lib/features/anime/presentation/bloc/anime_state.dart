import 'package:equatable/equatable.dart';

import '../../domain/entities/anime_character.dart';
import '../ui/models/anime_ui_model.dart';

abstract class AnimeState extends Equatable {
  @override
  List<Object> get props => [];
}

class AnimeInitial extends AnimeState {}

class AnimeListLoading extends AnimeState {}

class AnimeListFetched extends AnimeState {
  AnimeListFetched(this.animeList);

  final List<AnimeUiModel> animeList;

  @override
  List<Object> get props => [animeList];
}

class AnimeListFetchFailed extends AnimeState {}

class AnimeCharactersLoading extends AnimeState {}

class AnimeCharactersFetched extends AnimeState {
  AnimeCharactersFetched(this.characters);

  final List<AnimeCharacter> characters;

  @override
  List<Object> get props => [characters];
}

class AnimeCharactersFetchFailed extends AnimeState {}
