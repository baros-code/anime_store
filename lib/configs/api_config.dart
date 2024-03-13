import '../stack/common/models/api/api_setup_params.dart';

class ApiConfig {
  static const String baseUrl = 'https://api.jikan.moe/v4';

  static ApiSetupParams get setupParams => ApiSetupParams(
        baseUrl: baseUrl,
        retryCount: 1,
      );
}
