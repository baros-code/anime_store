import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../entities/anime_character_response.dart';
import '../repositories/anime_repository.dart';

class GetAnimeCharacters
    extends UseCase<int, Result<List<AnimeCharacterResponse>, Failure>, void> {
  GetAnimeCharacters(this._repository, super.logger);

  final AnimeRepository _repository;

  @override
  Future<Result<List<AnimeCharacterResponse>, Failure>> call({
    int? params,
  }) {
    return _repository.getAnimeCharacters(params!);
  }
}
