import '../interop/scheduled_event_intertop.dart' as interop;

import 'environment.dart';
import 'execution_context.dart';

class ScheduledEvent {
  final interop.ScheduledEvent _delegate;

  ScheduledEvent._(this._delegate);

  String get cron => _delegate.cron;
  String get scheduled => _delegate.scheduled;
  DateTime get scheduledTime =>
      DateTime.fromMillisecondsSinceEpoch(_delegate.scheduledTime);
  Environment get env => environmentFromJsObject(_delegate.env);
  ExecutionContext get ctx => executionContextFromJsObject(_delegate.ctx);
}

ScheduledEvent scheduledEventFromJsObject(interop.ScheduledEvent obj) =>
    ScheduledEvent._(obj);
