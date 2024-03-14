import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../configs/api_config.dart';
import '../../../../../stack/common/models/failure.dart';
import '../../../../../stack/common/models/result.dart';
import '../../../domain/use_cases/get_anime_list.dart';
import '../../models/anime_character_response_model.dart';
import '../../models/anime_response_model.dart';

abstract class AnimeRemoteService {
  Future<Result<AnimeResponseModel, Failure>> getAnimeList(
    GetAnimeListParams params,
  );

  Future<Result<AnimeCharacterResponseModel, Failure>> getAnimeCharacters(
    int animeId,
  );
}

class AnimeRemoteServiceImpl implements AnimeRemoteService {
  AnimeRemoteServiceImpl();

  final _channel = const MethodChannel('com.example/anime_store');
  final _animeListMethod = 'fetchAnimeList';
  final _animeCharactersMethod = 'fetchAnimeCharacters';

  @override
  Future<Result<AnimeResponseModel, Failure>> getAnimeList(
    GetAnimeListParams params,
  ) async {
    try {
      final queryParams = {
        'limit': params.pageSize.toString(),
        'page': params.startIndex.toString(),
        'type': params.queryText?.toString(),
      };
      queryParams.removeWhere((key, value) => value == null);
      final uri = Uri.https(
        ApiConfig.baseUrl,
        ApiConfig.animeListEndpoint,
        queryParams,
      );
      final result = await _channel.invokeMethod(
        _animeListMethod,
        {'url': uri.toString()},
      );
      final json = jsonDecode(result);
      return Result.success(value: AnimeResponseModel.fromJson(json));
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<AnimeCharacterResponseModel, Failure>> getAnimeCharacters(
    int animeId,
  ) async {
    try {
      final uri = Uri.https(
        ApiConfig.baseUrl,
        ApiConfig.getAnimeCharactersEndpoint(animeId),
      );
      final result = await _channel.invokeMethod(
        _animeCharactersMethod,
        {'url': uri.toString()},
      );
      final json = jsonDecode(result);
      return Result.success(value: AnimeCharacterResponseModel.fromJson(json));
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
