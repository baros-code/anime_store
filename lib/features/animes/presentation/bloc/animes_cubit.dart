import '../../../../stack/base/presentation/safe_cubit.dart';
import '../../domain/use_cases/get_animes.dart';
import '../ui/models/anime_ui_model.dart';
import 'animes_state.dart';

class AnimesCubit extends SafeCubit<AnimesState> {
  AnimesCubit(
    this._getAnimes,
  ) : super(AnimesInitial());

  final GetAnimes _getAnimes;

  final List<AnimeUiModel> animesCache = [];

  final int defaultPageSize = 5;
  bool isInitialLoading = true;
  // Initial value, will be updated after the first fetch
  int maxItemCount = 1;

  Future<bool> fetchAnimes(int pageIndex, {String? typeQuery}) async {
    if (pageIndex == 1) {
      animesCache.clear();
    }
    final result = await _getAnimes(
      params: GetAnimesParams(
        queryText: typeQuery,
        startIndex: pageIndex,
        pageSize: defaultPageSize,
      ),
    );
    if (result.isSuccessful) {
      final uiModels = result.value!.data.map(AnimeUiModel.fromEntity).toList();
      animesCache.addAll(uiModels);
      isInitialLoading = false;
      if (pageIndex == 1) maxItemCount = result.value!.pagination.items.total;
      emit(AnimesUpdated(animesCache));
      return true;
    }
    emit(AnimesFetchFailed());
    return false;
  }
  // Helpers

  // - Helpers
}
