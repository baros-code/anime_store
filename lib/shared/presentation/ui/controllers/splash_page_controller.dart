import 'package:flutter/animation.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/route_config.dart';
import '../../../../stack/base/presentation/controller.dart';

class SplashPageController extends Controller<Object> {
  SplashPageController(
    super.logger,
    super.popupManager,
  );

  late AnimationController animationController;

  final Duration _animationDuration = const Duration(seconds: 1);

  @override
  void onStart() {
    super.onStart();
    _initAnimation();
    // Spend some time to show the animation
    Future.delayed(
      _animationDuration,
      () => context.goNamed(AppRoutes.homeRoute.name),
    );
  }

  @override
  void onStop() {
    animationController.dispose();
    super.onStop();
  }

  // Helpers
  void _initAnimation() {
    animationController = AnimationController(
      duration: _animationDuration,
      vsync: vsync,
    );
    animationController.repeat();
  }
  // - Helpers
}
