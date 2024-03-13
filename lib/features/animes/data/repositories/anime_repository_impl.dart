import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../../domain/entities/anime_response.dart';
import '../../domain/repositories/anime_repository.dart';
import '../../domain/use_cases/get_animes.dart';
import '../data_sources/remote/anime_remote_service.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  AnimeRepositoryImpl(this._remoteService);

  final AnimeRemoteService _remoteService;

  @override
  Future<Result<AnimeResponse, Failure>> getAnimes(
    GetAnimesParams params,
  ) async {
    try {
      final result = await _remoteService.getAnimes(params);
      if (result.isSuccessful) {
        return Result.success(value: result.value!.toEntity());
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
