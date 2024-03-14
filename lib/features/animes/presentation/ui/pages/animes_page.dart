import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/ui/custom/widgets/page_title.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import '../../bloc/anime_cubit.dart';
import '../../bloc/anime_state.dart';
import '../controllers/animes_page_controller.dart';
import '../custom/widgets/anime_card.dart';
import '../custom/widgets/paginatable_list_view.dart';
import '../models/anime_ui_model.dart';

class AnimesPage extends ControlledView<AnimesPageController, Object> {
  AnimesPage({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeCubit, AnimeState>(
      buildWhen: (previous, current) => current is AnimeListUpdated,
      builder: (context, state) {
        return BasePage(
          title: const PageTitle('Anime Store'),
          body: _Body(state),
        );
      },
    );
  }
}

class _Body extends SubView<AnimesPageController> {
  _Body(this.state);

  final AnimeState state;
  @override
  Widget buildView(BuildContext context, AnimesPageController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: _buildListView(state, controller),
    );
  }

  Widget _buildListView(AnimeState state, AnimesPageController controller) {
    final animes =
        state is AnimeListUpdated ? state.animeList : controller.animeList;
    return PaginatableListView(
      items: _buildListViewItems(controller, animes),
      itemSpacing: 12,
      pageSize: controller.pageSize,
      maxItemCount: controller.maxItemCount,
      emptyMessage: 'There is no anime to show.',
      errorMessage: 'There was an error while loading, please try again.',
      onPagination: (pageIndex) {
        return controller.fetchAnimeList(pageIndex);
      },
    );
  }

  List<PaginatableListViewItem> _buildListViewItems(
    AnimesPageController controller,
    List<AnimeUiModel> items,
  ) {
    return items
        .map(
          (item) => PaginatableListViewItem(
            isVisible: item.isVisible,
            widget: _buildListViewItem(controller, item),
          ),
        )
        .toList();
  }

  Widget _buildListViewItem(
    AnimesPageController controller,
    AnimeUiModel item,
  ) {
    if (item.isVisible) {
      return AnimeCard(
        item.anime,
        onTap: () => controller.goToAnimeDetailsPage(item.anime),
      );
    }
    return const SizedBox.shrink();
  }
}
