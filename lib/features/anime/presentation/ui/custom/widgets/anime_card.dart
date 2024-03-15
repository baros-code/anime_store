import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../configs/asset_config.dart';
import '../../../../../../shared/presentation/extensions/build_context_ext.dart';
import '../../../../../../shared/presentation/ui/custom/widgets/custom_card.dart';
import '../../../../../../shared/presentation/ui/custom/widgets/custom_progress_spinner.dart';
import '../../../../domain/entities/anime.dart';

class AnimeCard extends StatelessWidget {
  const AnimeCard(
    this.anime, {
    super.key,
    this.isAnimeDetailsCard = false,
    this.onTap,
  });

  final Anime anime;
  final bool isAnimeDetailsCard;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CustomCard(
            height: 140,
            padding: const EdgeInsets.all(8),
            backgroundColor: context.colorScheme.background,
            showBorder: !isAnimeDetailsCard,
            borderRadius: isAnimeDetailsCard
                ? null
                : const BorderRadius.all(Radius.circular(8)),
            borderColor:
                isAnimeDetailsCard ? null : context.colorScheme.primary,
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
                        maxLines: isAnimeDetailsCard ? 2 : 1,
                      ),
                      Divider(
                        thickness: 1,
                        color: context.colorScheme.secondary,
                      ),
                      _CardContent(
                        'Rating score: ${anime.score}',
                        textStyle: context.textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      if (isAnimeDetailsCard) ...[
                        _CardContent('Genre: ${anime.allGenres}'),
                        _CardContent('Episodes: ${anime.episodes}'),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isAnimeDetailsCard) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(anime.synopsis),
            ),
          ]
        ],
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent(
    this.content, {
    this.textStyle,
    this.maxLines = 1,
  });

  final String content;
  final TextStyle? textStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: textStyle ?? context.textTheme.labelSmall,
    );
  }
}
