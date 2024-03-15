import '../../../../stack/base/presentation/safe_cubit.dart';
import '../../domain/use_cases/get_anime_characters.dart';
import '../../domain/use_cases/get_anime_list.dart';
import '../ui/models/anime_ui_model.dart';
import 'anime_state.dart';

class AnimeCubit extends SafeCubit<AnimeState> {
  AnimeCubit(
    this._getAnimeList,
    this._getAnimeCharacters,
  ) : super(AnimeInitial());

  final GetAnimeList _getAnimeList;
  final GetAnimeCharacters _getAnimeCharacters;

  final List<AnimeUiModel> animeCache = [];

  final int defaultPageSize = 5;
  bool isInitialLoading = true;
  // Initial value, will be updated after the first fetch
  int maxItemCount = 1;

  Future<bool> fetchAnimeList(int pageIndex, {String? typeQuery}) async {
    if (pageIndex == 1) {
      animeCache.clear();
    }
    final result = await _getAnimeList(
      params: GetAnimeListParams(
        queryText: typeQuery,
        startIndex: pageIndex,
        pageSize: defaultPageSize,
      ),
    );
    if (result.isSuccessful) {
      final uiModels = result.value!.data.map(AnimeUiModel.fromEntity).toList();
      animeCache.addAll(uiModels);
      isInitialLoading = false;
      if (pageIndex == 1) maxItemCount = result.value!.pagination.items.total;
      emit(AnimeListFetched(animeCache));
      return true;
    }
    emit(AnimeListFetchFailed());
    return false;
  }

  Future<void> fetchAnimeCharacters(int animeId) async {
    emit(AnimeCharactersLoading());
    final result = await _getAnimeCharacters(params: animeId);
    if (result.isSuccessful) {
      emit(
        AnimeCharactersFetched(result.value!.map((e) => e.character).toList()),
      );
    } else {
      emit(AnimeCharactersFetchFailed());
    }
  }
}
