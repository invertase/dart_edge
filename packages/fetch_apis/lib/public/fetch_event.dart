import 'dart:js_util' as js_util;
import 'dart:async';

import 'package:js_bindings/js_bindings.dart' as interop;

import '../interop/promise_interop.dart';
import 'request.dart';
import 'response.dart';

class FetchEvent {
  final interop.FetchEvent _delegate;
  FetchEvent._(this._delegate);

  String get type => _delegate.type;
  Request get request => requestFromJsObject(_delegate.request);

  void respondWith(FutureOr<Response> response) {
    return _delegate.respondWithPromise(Future(() async {
      return (await response).delegate;
    }));
  }
}

extension on interop.FetchEvent {
  /// This is a workaround for the fact that the `respondWith` method is
  /// probably checking for `instanceof Promise` instead of `then` method,
  /// so we force the incoming Future to be a Promise so the type is valid.
  void respondWithPromise(Future<interop.Response> r) =>
      js_util.callMethod(this, 'respondWith', [futureToPromise(r)]);
}

FetchEvent fetchEventFromJsObject(interop.FetchEvent fetchEvent) {
  return FetchEvent._(fetchEvent);
}
