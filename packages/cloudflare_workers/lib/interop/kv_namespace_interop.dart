import 'dart:js_util' as js_util;
import 'package:js/js.dart';

@JS()
@staticInterop
class KVNamespace {
  external factory KVNamespace();
}

extension PropsKVNamespace on KVNamespace {
  // TODO options
  String get(String name) => js_util.callMethod(this, 'get', [name]);
}
