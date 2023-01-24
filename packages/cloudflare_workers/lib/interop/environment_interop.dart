import 'dart:js_util' as js_util;
import 'package:js/js.dart';
import 'package:v8_runtime/interop/promise_interop.dart';

@JS()
@staticInterop
class Environment {
  external factory Environment();
}

extension PropsEnvironment on Environment {
  dynamic read(String name) => js_util.getProperty(this, name);
}
