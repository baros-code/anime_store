import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';

import '../entities/anime_response.dart';
import '../use_cases/get_anime_list.dart';

abstract class AnimeRepository {
  Future<Result<AnimeResponse, Failure>> getAnimeList(
    GetAnimeListParams params,
  );
}
