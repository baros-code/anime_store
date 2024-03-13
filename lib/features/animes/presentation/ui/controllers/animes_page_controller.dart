import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../configs/route_config.dart';
import '../../../../../stack/base/presentation/controller.dart';
import '../../bloc/animes_cubit.dart';
import '../models/anime_ui_model.dart';

class AnimesPageController extends Controller<Object> {
  AnimesPageController(super.logger, super.popupManager);

  late AnimesCubit _animesCubit;

  List<AnimeUiModel> get animes => _animesCubit.animesCache;

  int get pageSize => _animesCubit.defaultPageSize;

  bool get isInitialLoading => _animesCubit.isInitialLoading;

  int get maxItemCount => _animesCubit.maxItemCount;

  @override
  void onStart() {
    super.onStart();
    _animesCubit = context.read<AnimesCubit>();
    // fetchAnimes(0);
  }

  Future<bool> fetchAnimes(int pageIndex) {
    return _animesCubit.fetchAnimes(pageIndex);
  }

  void goToAnimeDetailsPage() {
    context.goNamed(AppRoutes.animeDetailsRoute.name);
  }
}
