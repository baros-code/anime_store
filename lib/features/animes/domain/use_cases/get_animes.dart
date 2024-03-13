import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../entities/anime_response.dart';
import '../repositories/anime_repository.dart';

class GetAnimes
    extends UseCase<GetAnimesParams, Result<AnimeResponse, Failure>, void> {
  GetAnimes(this._repository, super.logger);

  final AnimeRepository _repository;

  @override
  Future<Result<AnimeResponse, Failure>> execute({GetAnimesParams? params}) {
    return _repository.getAnimes(params!);
  }
}

class GetAnimesParams {
  GetAnimesParams({
    required this.queryText,
    required this.pageSize,
    required this.startIndex,
  });

  final String? queryText;
  final int pageSize;
  final int startIndex;
}
