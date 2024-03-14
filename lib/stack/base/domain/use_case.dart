import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/logging/logger.dart';

abstract class UseCase<TInput, TOutput, TEvent> extends _UseCaseBase<TEvent> {
  UseCase(super.logger);

  FutureOr<TOutput?> call({TInput? params});
}

abstract class StreamUseCase<TInput, TOutput, TEvent>
    extends _UseCaseBase<TEvent> {
  StreamUseCase(super.logger);

  Stream<TOutput?> call({TInput? params});
}

abstract class _UseCaseBase<TEvent> {
  _UseCaseBase(this.logger);

  final Logger logger;

  final _eventController = StreamController<TEvent>();

  Stream<TEvent> get onEvent => _eventController.stream;

  /// Publishes the given [event] to the subscribers of [onEvent].
  @protected
  void publish(TEvent event) {
    if (_eventController.hasListener) _eventController.add(event);
  }

  /// Useful to be overriden to stop a long running execution.
  @mustCallSuper
  Future<void> stop() async {
    await _eventController.close();
  }
}
