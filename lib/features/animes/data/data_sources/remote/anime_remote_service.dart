import '../../../../../stack/common/models/failure.dart';
import '../../../../../stack/common/models/result.dart';
import '../../../../../stack/core/network/api_manager.dart';
import '../../../domain/use_cases/get_animes.dart';
import '../../models/anime_response_model.dart';
import 'anime_api.dart';

abstract class AnimeRemoteService {
  Future<Result<AnimeResponseModel, Failure>> getAnimes(
    GetAnimesParams params,
  );
}

class AnimeRemoteServiceImpl implements AnimeRemoteService {
  AnimeRemoteServiceImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<Result<AnimeResponseModel, Failure>> getAnimes(
    GetAnimesParams params,
  ) async {
    return _apiManager.call(
      AnimeApi.getAnimes(
        typeQuery: params.queryText,
        pageSize: params.pageSize,
        pageIndex: params.startIndex,
      ),
    );
  }
}
