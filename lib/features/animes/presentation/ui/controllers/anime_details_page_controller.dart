import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../stack/base/presentation/controller.dart';
import '../../bloc/animes_cubit.dart';
import '../models/anime_ui_model.dart';

class AnimeDetailsPageController extends Controller<Object> {
  AnimeDetailsPageController(
    super.logger,
    super.popupManager,
  );

  late AnimesCubit _animesCubit;

  List<AnimeUiModel> get animes => _animesCubit.animesCache;

  @override
  void onStart() {
    super.onStart();
    _animesCubit = context.read<AnimesCubit>();
  }
}
