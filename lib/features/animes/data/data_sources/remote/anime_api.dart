import '../../../../../features/animes/data/models/anime_response_model.dart';
import '../../../../../stack/common/models/api/api_call.dart';
import '../../../../../stack/common/models/api/api_method.dart';
import '../../models/anime_character_response_model.dart';

abstract class AnimeApi {
  static ApiCall<AnimeResponseModel> getAnimes({
    String? typeQuery,
    int? pageSize,
    int? pageIndex,
  }) {
    final queryParams = {
      'type': typeQuery,
      'limit': pageSize,
      'page': pageIndex,
    };
    queryParams.removeWhere((key, value) => value == null);

    return ApiCall(
      method: ApiMethod.get,
      path: '/top/anime',
      queryParams: queryParams,
      responseMapper: (response) => AnimeResponseModel.fromJson(response),
    );
  }

  static ApiCall<List<AnimeCharacterResponseModel>> getAnimeCharacters({
    required String animeId,
  }) {
    return ApiCall(
      method: ApiMethod.get,
      path: '/anime/$animeId/characters',
      responseMapper: (response) {
        return (response['data'] as List)
            .map((e) => AnimeCharacterResponseModel.fromJson(e))
            .toList();
      },
    );
  }
}
