import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/animes/domain/entities/anime.dart';
import '../features/animes/presentation/ui/pages/anime_details_page.dart';
import '../features/animes/presentation/ui/pages/animes_page.dart';
import '../shared/presentation/ui/pages/error_page.dart';
import '../shared/presentation/ui/pages/splash_page.dart';

class RouteConfig {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splashRoute.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splashRoute.path,
        name: AppRoutes.splashRoute.name,
        pageBuilder: (context, state) {
          return _buildPage(page: SplashPage(), state: state);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.homeRoute.path,
        name: AppRoutes.homeRoute.name,
        pageBuilder: (context, state) {
          return _buildPage(page: AnimesPage(), state: state);
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: AppRoutes.animeDetailsRoute.path,
            name: AppRoutes.animeDetailsRoute.name,
            pageBuilder: (context, state) {
              final anime = state.extra as Anime;
              return _buildPage(
                page: AnimeDetailsPage(params: anime),
                state: state,
              );
            },
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) {
      return _buildPage(page: const ErrorPage(), state: state);
    },
  );

  static GoRouter get router => _router;

  static Page<Widget> _buildPage({
    required Widget page,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          _buildTransition(animation, child),
      child: page,
    );
  }

  static Widget _buildTransition(Animation<double> animation, Widget child) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    const curve = Curves.ease;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

enum AppRoutes {
  splashRoute('/splash'),
  homeRoute('/home'),
  animeDetailsRoute('animeDetails');

  const AppRoutes(this.path);

  final String path;

  String get name => path.replaceAll('/', '');
}
