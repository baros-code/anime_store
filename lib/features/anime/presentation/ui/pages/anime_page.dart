import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/extensions/build_context_ext.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import '../../bloc/anime_cubit.dart';
import '../../bloc/anime_state.dart';
import '../controllers/anime_page_controller.dart';
import '../custom/widgets/anime_card.dart';
import '../custom/widgets/paginatable_list_view.dart';
import '../models/anime_ui_model.dart';

class AnimePage extends ControlledView<AnimePageController, Object> {
  AnimePage({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeCubit, AnimeState>(
      buildWhen: (previous, current) => current is AnimeListFetched,
      builder: (context, state) {
        return BasePage(
          title: const _Title('Anime Store'),
          body: _Body(state),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.headlineLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Body extends SubView<AnimePageController> {
  _Body(this.state);

  final AnimeState state;
  @override
  Widget buildView(BuildContext context, AnimePageController controller) {
    return _buildViews(state, controller);
  }

  Widget _buildViews(AnimeState state, AnimePageController controller) {
    final animeList =
        state is AnimeListFetched ? state.animeList : controller.animeList;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: PaginatableListView(
        items: _buildListViewItems(controller, animeList),
        pageSize: controller.pageSize,
        itemSpacing: 12,
        maxItemCount: controller.maxItemCount,
        errorMessage: 'There was an error while loading, please try again.',
        onPagination: (pageIndex) {
          return controller.fetchAnimeList(pageIndex);
        },
      ),
    );
  }

  List<PaginatableListViewItem> _buildListViewItems(
    AnimePageController controller,
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
    AnimePageController controller,
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
