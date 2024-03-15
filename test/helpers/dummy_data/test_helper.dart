import 'package:anime_store/features/animes/data/data_sources/remote/anime_remote_service.dart';
import 'package:anime_store/features/animes/domain/repositories/anime_repository.dart';
import 'package:anime_store/features/animes/domain/use_cases/get_anime_characters.dart';
import 'package:anime_store/features/animes/domain/use_cases/get_anime_list.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    AnimeRemoteService,
    AnimeRepository,
    GetAnimeList,
    GetAnimeCharacters,
  ],
)
void main() {}
