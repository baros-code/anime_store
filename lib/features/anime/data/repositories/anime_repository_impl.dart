import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../../domain/entities/anime_character_response.dart';
import '../../domain/entities/anime_response.dart';
import '../../domain/repositories/anime_repository.dart';
import '../../domain/use_cases/get_anime_list.dart';
import '../data_sources/remote/anime_remote_service.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  AnimeRepositoryImpl(this._remoteService);

  final AnimeRemoteService _remoteService;

  @override
  Future<Result<AnimeResponse, Failure>> getAnimeList(
    GetAnimeListParams params,
  ) async {
    try {
      final result = await _remoteService.getAnimeList(params);
      if (result.isSuccessful) {
        return Result.success(value: result.value!.toEntity());
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<AnimeCharacterResponse>, Failure>> getAnimeCharacters(
    int animeId,
  ) async {
    try {
      final result = await _remoteService.getAnimeCharacters(animeId);
      if (result.isSuccessful) {
        return Result.success(
          value: result.value!.map((e) => e.toEntity()).toList(),
        );
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
