part of 'dependency_imports.dart';

abstract class DependencyConfig {
  static void register() {
    _registerControllers();
    _registerCubits();
    _registerUseCases();
    _registerRepositories();
    _registerRemoteServices();
    _registerModels();
  }

  static void _registerControllers() {
    locator.registerFactory(
      () => SplashPageController(locator(), locator()),
    );
    locator.registerFactory(
      () => AnimesPageController(locator(), locator()),
    );
    locator.registerFactory(
      () => AnimeDetailsPageController(locator(), locator()),
    );
  }

  static void _registerCubits() {
    locator.registerFactory(
      () => AnimesCubit(locator()),
    );
  }

  static void _registerUseCases() {
    locator.registerFactory(
      () => GetAnimes(locator(), locator()),
    );
  }

  static void _registerRepositories() {
    locator.registerLazySingleton<AnimeRepository>(
      () => AnimeRepositoryImpl(locator()),
    );
  }

  static void _registerRemoteServices() {
    locator.registerLazySingleton<AnimeRemoteService>(
      () => AnimeRemoteServiceImpl(locator()),
    );
  }

  static void _registerModels() {
    locator.registerFactoryParam<AnimeModel, Map<String, dynamic>, void>(
      (json, _) => AnimeModel.fromJson(json),
    );
  }
}
