import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../../configs/asset_config.dart';
import '../../../../../shared/presentation/extensions/build_context_ext.dart';
import '../../../../../shared/presentation/extensions/widget_ext.dart';
import '../../../../../shared/presentation/ui/custom/widgets/custom_card.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import '../../../domain/entities/anime.dart';
import '../../../domain/entities/anime_character.dart';
import '../../bloc/anime_cubit.dart';
import '../../bloc/anime_state.dart';
import '../controllers/anime_details_page_controller.dart';
import '../custom/widgets/anime_card.dart';

class AnimeDetailsPage
    extends ControlledView<AnimeDetailsPageController, Anime> {
  AnimeDetailsPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimeCubit, AnimeState>(
      listener: (context, state) => controller.handleStates(state),
      buildWhen: (previous, current) =>
          current is AnimeCharactersLoading ||
          current is AnimeCharactersFetched,
      builder: (context, state) {
        return BasePage(
          title: const _Title('Anime Details'),
          backButtonEnabled: true,
          body: _buildView(context, state),
        );
      },
    );
  }

  Widget _buildView(BuildContext context, AnimeState state) {
    if (state is AnimeCharactersFetched) {
      return _Body(state.characters);
    }
    return const CircularProgressIndicator().centered();
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.headlineSmall,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Body extends SubView<AnimeDetailsPageController> {
  _Body(this.characters);

  final List<AnimeCharacter> characters;
  @override
  Widget buildView(
    BuildContext context,
    AnimeDetailsPageController controller,
  ) {
    final anime = controller.anime;
    return SingleChildScrollView(
      child: Column(
        children: [
          AnimeCard(anime, isAnimeDetailsCard: true),
          const SizedBox(height: 16),
          _CharactersSection(characters),
        ],
      ),
    );
  }
}

class _CharactersSection extends StatefulWidget {
  const _CharactersSection(this.characters);

  final List<AnimeCharacter> characters;

  @override
  State<_CharactersSection> createState() => _CharactersSectionState();
}

class _CharactersSectionState extends State<_CharactersSection> {
  int _itemsNumber = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Title('Characters'),
        const SizedBox(height: 16),
        CustomCard(
          height: 250,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) =>
                _handleScroll(scrollNotification),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _itemsNumber,
              itemBuilder: (context, index) {
                return _CharacterCard(widget.characters[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  bool _handleScroll(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.pixels ==
            scrollNotification.metrics.maxScrollExtent &&
        _itemsNumber < widget.characters.length) {
      setState(() {
        _itemsNumber += 6;
        if (_itemsNumber > widget.characters.length) {
          _itemsNumber = widget.characters.length;
        }
      });
    }
    return false;
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard(
    this.character,
  );

  final AnimeCharacter character;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: character.images.jpg.imageUrl,
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            // Keep this low to avoid memory issues & app crash
            memCacheWidth: 100,
            errorWidget: (context, url, error) => Image.asset(AssetConfig.logo),
          ),
        ),
        Text(
          character.name,
          style: context.textTheme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
