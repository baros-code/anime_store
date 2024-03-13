import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';

import '../entities/anime_response.dart';
import '../use_cases/get_animes.dart';

abstract class AnimeRepository {
  Future<Result<AnimeResponse, Failure>> getAnimes(GetAnimesParams params);
}
