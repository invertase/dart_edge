import '../interop/scheduled_event_interop.dart' as interop;

class ScheduledEvent {
  final interop.ScheduledEvent _delegate;

  ScheduledEvent._(this._delegate);

  String get cron => _delegate.cron;
  String get scheduled => _delegate.scheduled;
  DateTime get scheduledTime =>
      DateTime.fromMillisecondsSinceEpoch(_delegate.scheduledTime);
}

ScheduledEvent scheduledEventFromJsObject(interop.ScheduledEvent obj) =>
    ScheduledEvent._(obj);
