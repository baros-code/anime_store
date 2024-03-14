class ApiConfig {
  static const String baseUrl = 'api.jikan.moe';

  static const String animeListEndpoint = '/v4/top/anime';

  static String getAnimeCharactersEndpoint(int animeId) {
    return '/v4/anime/$animeId/characters';
  }
}
