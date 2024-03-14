import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../entities/anime_response.dart';
import '../repositories/anime_repository.dart';

class GetAnimeList
    extends UseCase<GetAnimeListParams, Result<AnimeResponse, Failure>, void> {
  GetAnimeList(this._repository, super.logger);

  final AnimeRepository _repository;

  @override
  Future<Result<AnimeResponse, Failure>> call({GetAnimeListParams? params}) {
    return _repository.getAnimeList(params!);
  }
}

class GetAnimeListParams {
  GetAnimeListParams({
    required this.queryText,
    required this.pageSize,
    required this.startIndex,
  });

  final String? queryText;
  final int pageSize;
  final int startIndex;
}
