import 'dart:js_util' as js_util;
import 'package:js/js.dart';

import 'environment_interop.dart' as interop;
import 'execution_context_interop.dart' as interop;

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
  interop.Environment get env => js_util.getProperty(this, 'env');
  interop.ExecutionContext get ctx => js_util.getProperty(this, 'ctx');

  // TODO wait until
}
