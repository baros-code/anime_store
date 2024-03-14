import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../stack/base/presentation/controller.dart';
import '../../../domain/entities/anime.dart';
import '../../bloc/anime_cubit.dart';

class AnimeDetailsPageController extends Controller<Anime> {
  AnimeDetailsPageController(
    super.logger,
    super.popupManager,
  );

  late Anime anime;
  late AnimeCubit _animesCubit;

  @override
  void onStart() {
    super.onStart();
    anime = params!;
    _animesCubit = context.read<AnimeCubit>();
  }
}
