import 'package:flutter/material.dart';

import '../../../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../../shared/presentation/ui/custom/widgets/page_title.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import '../controllers/anime_details_page_controller.dart';

class AnimeDetailsPage
    extends ControlledView<AnimeDetailsPageController, Object> {
  AnimeDetailsPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const PageTitle('Anime Detay'),
      backButtonEnabled: true,
      body: _Body(),
    );
  }
}

class _Body extends SubView<AnimeDetailsPageController> {
  @override
  Widget buildView(
    BuildContext context,
    AnimeDetailsPageController controller,
  ) {
    return Container();
  }
}
