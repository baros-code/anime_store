import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../configs/route_config.dart';
import '../../../../../stack/base/presentation/controller.dart';
import '../../../domain/entities/anime.dart';
import '../../bloc/anime_cubit.dart';
import '../models/anime_ui_model.dart';

class AnimePageController extends Controller<Object> {
  AnimePageController(super.logger, super.popupManager);

  late AnimeCubit _animeCubit;

  List<AnimeUiModel> get animeList => _animeCubit.animeCache;

  int get pageSize => _animeCubit.defaultPageSize;

  int get maxItemCount => _animeCubit.maxItemCount;

  @override
  void onStart() {
    super.onStart();
    _animeCubit = context.read<AnimeCubit>();
  }

  Future<bool> fetchAnimeList(int pageIndex) {
    return _animeCubit.fetchAnimeList(pageIndex);
  }

  void goToAnimeDetailsPage(Anime anime) {
    context.goNamed(AppRoutes.animeDetailsRoute.name, extra: anime);
  }
}
