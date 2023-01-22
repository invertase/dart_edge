import 'dart:js_util' show jsify;
import 'package:js_bindings/js_bindings.dart' as interop;

class Headers {
  final interop.Headers _delegate;

  Headers([Map<String, String>? headers])
      : _delegate = interop.Headers(jsify(headers ?? {}));

  Headers._(this._delegate);

  bool has(String name) => _delegate.has(name);
  void append(String name, String value) => _delegate.append(name, value);
  void delete(String name) => _delegate.delete(name);

  operator []=(String name, String value) {
    _delegate.mSet(name, value);
  }

  dynamic operator [](String name) {
    return _delegate.mGet(name);
  }
}

extension HeadersExtension on Headers {
  // Returns the underlying JS object.
  interop.Headers get delegate => _delegate;
}

// Creates a [Headers] instance from a JS object.
Headers headersFromJsObject(interop.Headers delegate) {
  return Headers._(delegate);
}
