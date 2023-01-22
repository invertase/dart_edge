import 'dart:js_util' as js_util;
import 'package:js/js.dart' as js;
import 'package:js_bindings/js_bindings.dart' as interop;

import 'promise_interop.dart';

@js.JS()
external void addEventListener(
  String type,
  void Function(interop.ExtendableEvent event) callback,
);

@js.JS('fetch')
external Promise<interop.Response> fetch(
  interop.Request request, [
  Object? init,
]);
