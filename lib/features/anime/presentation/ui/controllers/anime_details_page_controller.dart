import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../stack/base/presentation/controller.dart';
import '../../../domain/entities/anime.dart';
import '../../bloc/anime_cubit.dart';
import '../../bloc/anime_state.dart';

class AnimeDetailsPageController extends Controller<Anime> {
  AnimeDetailsPageController(
    super.logger,
    super.popupManager,
  );

  late Anime anime;
  late AnimeCubit _animeCubit;

  @override
  void onStart() {
    super.onStart();
    anime = params!;
    _animeCubit = context.read<AnimeCubit>();
    _animeCubit.fetchAnimeCharacters(anime.id);
  }

  void handleStates(AnimeState state) {
    if (state is AnimeCharactersFetchFailed) {
      popupManager.showSnackBar(
        context,
        const Text('Failed to fetch characters'),
      );
    }
  }
}
