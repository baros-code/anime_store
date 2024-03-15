import '../../features/anime/data/data_sources/remote/anime_remote_service.dart';
import '../../features/anime/data/models/anime_model.dart';
import '../../features/anime/data/repositories/anime_repository_impl.dart';
import '../../features/anime/domain/repositories/anime_repository.dart';
import '../../features/anime/domain/use_cases/get_anime_characters.dart';
import '../../features/anime/domain/use_cases/get_anime_list.dart';
import '../../features/anime/presentation/bloc/anime_cubit.dart';
import '../../features/anime/presentation/ui/controllers/anime_details_page_controller.dart';
import '../../features/anime/presentation/ui/controllers/anime_page_controller.dart';
import '../../shared/presentation/ui/controllers/splash_page_controller.dart';
import '../../stack/core/ioc/service_locator.dart';

part 'dependency_config.dart';
