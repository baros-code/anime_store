import '../../features/animes/data/data_sources/remote/anime_remote_service.dart';
import '../../features/animes/data/models/anime_model.dart';
import '../../features/animes/data/repositories/anime_repository_impl.dart';
import '../../features/animes/domain/repositories/anime_repository.dart';
import '../../features/animes/domain/use_cases/get_anime_characters.dart';
import '../../features/animes/domain/use_cases/get_anime_list.dart';
import '../../features/animes/presentation/bloc/anime_cubit.dart';
import '../../features/animes/presentation/ui/controllers/anime_details_page_controller.dart';
import '../../features/animes/presentation/ui/controllers/animes_page_controller.dart';
import '../../shared/presentation/ui/controllers/splash_page_controller.dart';
import '../../stack/core/ioc/service_locator.dart';

part 'dependency_config.dart';
