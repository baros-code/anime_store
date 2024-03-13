import 'package:flutter/material.dart';

import '../../../../../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../configs/asset_config.dart';
import '../../../../stack/base/presentation/sub_view.dart';
import '../controllers/splash_page_controller.dart';

class SplashPage extends ControlledView<SplashPageController, Object> {
  SplashPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: _Logo()),
      ),
    );
  }
}

class _Logo extends SubView<SplashPageController> {
  @override
  Widget buildView(BuildContext context, SplashPageController controller) {
    return SizedBox(
      height: 200,
      child: Image.asset(AssetConfig.logo),
    );
  }
}
