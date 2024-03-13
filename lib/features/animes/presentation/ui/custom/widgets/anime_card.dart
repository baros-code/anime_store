import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../configs/asset_config.dart';
import '../../../../../../shared/presentation/extensions/build_context_ext.dart';
import '../../../../../../shared/presentation/ui/custom/widgets/custom_card.dart';
import '../../../../../../shared/presentation/ui/custom/widgets/custom_progress_spinner.dart';
import '../../../../domain/entities/anime.dart';

class AnimeCard extends StatefulWidget {
  const AnimeCard(
    this.anime, {
    super.key,
    required this.onTap,
  });

  final Anime anime;
  final void Function()? onTap;

  @override
  State<AnimeCard> createState() => _AnimeCardState();
}

class _AnimeCardState extends State<AnimeCard> {
  @override
  Widget build(BuildContext context) {
    final anime = widget.anime;
    return GestureDetector(
      onTap: widget.onTap,
      child: CustomCard(
        height: 120,
        padding: const EdgeInsets.all(8),
        backgroundColor: context.colorScheme.background,
        showBorder: true,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderColor: context.colorScheme.primary,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: anime.jpgUrl,
              fit: BoxFit.cover,
              width: 80,
              placeholder: (context, url) => const CustomProgressSpinner(),
              errorWidget: (context, url, error) =>
                  Image.asset(AssetConfig.logo),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardContent(
                    anime.title,
                    textStyle: context.textTheme.headlineSmall,
                  ),
                  Divider(thickness: 1, color: context.colorScheme.secondary),
                  const Spacer(),
                  _CardContent('Rating score: ${anime.score}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent(
    this.content, {
    this.textStyle,
  });

  final String content;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textStyle ?? context.textTheme.labelSmall,
    );
  }
}
