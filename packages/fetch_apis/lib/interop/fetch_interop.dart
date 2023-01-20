import 'dart:js_util' as js_util;
import 'package:js/js.dart' as js;
import 'package:js_bindings/js_bindings.dart' as interop;

export 'cf_cache_interop.dart' show defaultCache;

@js.JS()
external void addEventListener(
  String type,
  void Function(interop.ExtendableEvent event) callback,
);

@js.JS()
class Promise<T> {
  external Promise(
      void Function(void Function(T result) resolve, Function reject) executor);
  external Promise then(void Function(T result) onFulfilled,
      [Function onRejected]);
}

Promise<T> futureToPromise<T>(Future<T> future) {
  return Promise<T>(js.allowInterop((resolve, reject) {
    future.then(resolve, onError: reject);
  }));
}

extension FetchEventExtension on interop.FetchEvent {
  void respondWithPromise(Future<interop.Response> r) =>
      js_util.callMethod(this, 'respondWith', [futureToPromise(r)]);
}

@js.JS('fetch')
external Promise<interop.Response> fetch(
  interop.Request request, [
  interop.RequestInit init,
]);

@js.JS('Object.keys')
external List<Object?> objectKeys(Object? object);

@js.JS('caches')
external interop.CacheStorage get caches;

@js.JS('undefined')
external Object get jsUndefined;

bool _isBasicType(value) {
  if (value == null || value is num || value is bool || value is String) {
    return true;
  }
  return false;
}

T dartify<T>(dynamic jsObject) {
  if (_isBasicType(jsObject)) {
    return jsObject as T;
  }

  if (jsObject is List) {
    return jsObject.map(dartify).toList() as T;
  }

  var keys = objectKeys(jsObject);
  var result = <String, dynamic>{};
  for (var key in keys) {
    result[key as String] = dartify(js_util.getProperty(jsObject, key));
  }

  return result as T;
}
