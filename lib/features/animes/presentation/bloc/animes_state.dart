import '../ui/models/anime_ui_model.dart';

abstract class AnimesState {}

class AnimesInitial extends AnimesState {}

class AnimesUpdated extends AnimesState {
  AnimesUpdated(this.animes);

  final List<AnimeUiModel> animes;
}

class AnimesFetchFailed extends AnimesState {}
