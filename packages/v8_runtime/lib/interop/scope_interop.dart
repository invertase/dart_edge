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
  // TODO: Using `interop.RequestInit` here causes a runtime error where
  // null vs undefined is not handled correctly.
  Object? init,
]);

@js.JS('atob')
external String atob(String encodedData);

@js.JS('btoa')
external String btoa(String encodedData);

@js.JS('setInterval')
external int setInterval(
  void Function() callback,
  int milliseconds,
);

@js.JS('clearInterval')
external void clearInterval(int handle);

@js.JS('setTimeout')
external int setTimeout(
  void Function() callback,
  int milliseconds,
);

@js.JS('clearTimeout')
external void clearTimeout(int handle);

@js.JS('_fetch')
external interop.FetchEvent get fooFetch;
