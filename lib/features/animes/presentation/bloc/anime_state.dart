import '../ui/models/anime_ui_model.dart';

abstract class AnimeState {}

class AnimeInitial extends AnimeState {}

class AnimeListUpdated extends AnimeState {
  AnimeListUpdated(this.animeList);

  final List<AnimeUiModel> animeList;
}

class AnimeListFetchFailed extends AnimeState {}
