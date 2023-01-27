import 'dart:js_util' as js_util;
import 'package:js/js.dart';

@anonymous
@JS()
@staticInterop
class ScheduledEvent {
  external factory ScheduledEvent();
}

extension PropsScheduledEvent on ScheduledEvent {
  String get cron => js_util.getProperty(this, 'cron');
  String get scheduled => js_util.getProperty(this, 'scheduled');
  int get scheduledTime => js_util.getProperty(this, 'scheduledTime');

  // TODO wait until
}
