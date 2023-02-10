import 'package:js/js.dart';
import 'dart:js_util' as js_util;

@JS('Deno.env')
external Env get env;

@JS()
@staticInterop
class Env {
  external factory Env();
}

extension PropsEnv on Env {
  String? get(String key) => js_util.callMethod(this, 'get', [key]);
  void set(String key, String value) =>
      js_util.callMethod(this, 'set', [key, value]);
  void delete(String key) => js_util.callMethod(this, 'delete', [key]);
  bool has(String key) => js_util.callMethod(this, 'has', [key]);
  dynamic toObject() => js_util.callMethod(this, 'toObject', []);
}
