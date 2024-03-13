import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/ui/custom/widgets/page_title.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import '../../bloc/animes_cubit.dart';
import '../../bloc/animes_state.dart';
import '../controllers/animes_page_controller.dart';
import '../custom/widgets/anime_card.dart';
import '../custom/widgets/paginatable_list_view.dart';
import '../models/anime_ui_model.dart';

class AnimesPage extends ControlledView<AnimesPageController, Object> {
  AnimesPage({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimesCubit, AnimesState>(
      buildWhen: (previous, current) => current is AnimesUpdated,
      builder: (context, state) {
        return BasePage(
          title: const PageTitle('Anime Store'),
          // Prevents the anime icon to move up when keyboard is opened
          resizeToAvoidBottomInset: false,
          body: _Body(state),
        );
      },
    );
  }
}

class _Body extends SubView<AnimesPageController> {
  _Body(this.state);

  final AnimesState state;
  @override
  Widget buildView(BuildContext context, AnimesPageController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: _buildListView(state, controller),
    );
  }

  Widget _buildListView(AnimesState state, AnimesPageController controller) {
    final animes = state is AnimesUpdated ? state.animes : controller.animes;
    return PaginatableListView(
      items: _buildListViewItems(controller, animes),
      itemSpacing: 12,
      pageSize: controller.pageSize,
      maxItemCount: controller.maxItemCount,
      emptyMessage: 'There is no anime to show.',
      errorMessage: 'There was an error while loading, please try again.',
      onPagination: (pageIndex) {
        return controller.fetchAnimes(pageIndex);
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
        onTap: controller.goToAnimeDetailsPage,
      );
    }
    return const SizedBox.shrink();
  }
}
