import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../configs/route_config.dart';
import '../../../../../stack/base/presentation/controller.dart';
import '../../../domain/entities/anime.dart';
import '../../bloc/anime_cubit.dart';
import '../models/anime_ui_model.dart';

class AnimesPageController extends Controller<Object> {
  AnimesPageController(super.logger, super.popupManager);

  late AnimeCubit _animesCubit;

  List<AnimeUiModel> get animeList => _animesCubit.animeCache;

  int get pageSize => _animesCubit.defaultPageSize;

  bool get isInitialLoading => _animesCubit.isInitialLoading;

  int get maxItemCount => _animesCubit.maxItemCount;

  @override
  void onStart() {
    super.onStart();
    _animesCubit = context.read<AnimeCubit>();
  }

  Future<bool> fetchAnimeList(int pageIndex) {
    return _animesCubit.fetchAnimeList(pageIndex);
  }

  void goToAnimeDetailsPage(Anime anime) {
    context.goNamed(AppRoutes.animeDetailsRoute.name, extra: anime);
  }
}
