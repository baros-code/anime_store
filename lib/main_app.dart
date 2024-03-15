import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configs/route_config.dart';
import 'configs/theme/theme.dart';
import 'features/anime/presentation/bloc/anime_cubit.dart';
import 'stack/core/ioc/service_locator.dart';
import 'stack/core/logging/logger.dart';

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.logger,
  });

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _buildCubitProviders(),
      child: MaterialApp.router(
        themeMode: ThemeMode.dark,
        routerConfig: RouteConfig.router,
        title: 'Anime Store',
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
      ),
    );
  }

  // Helpers
  List<BlocProvider> _buildCubitProviders() {
    return [
      BlocProvider<AnimeCubit>(
        create: (context) => locator<AnimeCubit>(),
      ),
    ];
  }
  // - Helpers
}
