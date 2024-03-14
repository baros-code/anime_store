import 'dart:async';

import 'package:flutter/material.dart';

import 'configs/dependency/dependency_imports.dart';
import 'main_app.dart';
import 'stack/core/ioc/service_locator.dart';
import 'stack/core/logging/logger.dart';

void main() {
  runZonedGuarded(
    () async {
      await _initializeComponents();
      FlutterError.onError = _onFlutterError;
      runApp(
        MainApp(
          logger: locator<Logger>(),
        ),
      );
    },
    _onDartError,
  );
}

Future<void> _initializeComponents() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.initialize(external: DependencyConfig.register);
}

void _onFlutterError(FlutterErrorDetails error) {
  FlutterError.presentError(error);
  locator<Logger>().critical(
    error.toString(minLevel: DiagnosticLevel.error),
  );
}

void _onDartError(Object error, StackTrace stack) {
  locator<Logger>().critical(
    '${error.toString()}\n${stack.toString()}',
  );
}
